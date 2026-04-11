import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { OrdenDiagnostico } from './entities/orden-diagnostico.entity';
import { CreateOrdenDiagnosticoDto } from './dto/create-orden-diagnostico.dto';


@Injectable()
export class OrdenDiagnosticoService {
  constructor(
    @InjectRepository(OrdenDiagnostico)
    private readonly ordenRepo: Repository<OrdenDiagnostico>,
  ) {}

  async findLastId(): Promise<number> {
    try {
      const ultimaOrden = await this.ordenRepo.find({
        select: ['IdOrden'], // <--- ESTO ES CLAVE: Solo pide el ID, ignora lo demás
        order: { IdOrden: 'DESC' } as any,
        take: 1,
      });
      
      if (ultimaOrden.length > 0) {
        return Number(ultimaOrden[0].IdOrden) + 1;
      }
      return 1;
    } catch (error) {
      console.error('Error crítico en el contador:', error);
      return 1;
    }
  }

  /*async create(createDto: CreateOrdenDiagnosticoDto) { 
    const nuevaOrden = this.ordenRepo.create({
      IdOrden: createDto.IdOrden,
      FechaCreacion: createDto.FechaCreacion,
      Descripcion: createDto.Descripcion,
      EstadoRecepcion: createDto.EstadoRecepcion,
      equipo: { NumeroSerie: createDto.SerieEquipo } as any,
      cliente: { IdCliente: createDto.IdClienteD } as any,
      prioridad: { IdPrioridad: createDto.Prioridad } as any
    });

    return await this.ordenRepo.save(nuevaOrden);
  }*/

  async create(createDto: any) {
    try {
      // 1. Validación de seguridad
      if (!createDto.SerieEquipo || !createDto.IdClienteD) {
        throw new Error("Faltan datos obligatorios (Serie o Cliente)");
      }

      // 2. Definición de la consulta para el SP
    const query = `
    EXEC sp_IgresarOrdenDiagnostico 
      @IdOrden = @0,
      @FechaCreacion = @1,
      @Descripcion = @2,
      @EstadoRecepcion = @3,
      @SerieEquipo = @4,
      @IdClienteD = @5,
      @Prioridad = @6
    `;

      // 3. Preparación de parámetros
    const parametros = [
        createDto.IdOrden,
        createDto.FechaCreacion, // SQL Server acepta el string 'YYYY-MM-DD'
        createDto.Descripcion || "Sin descripción",
        createDto.EstadoRecepcion || "No especificado",
        createDto.SerieEquipo,
        createDto.IdClienteD,
        createDto.Prioridad
    ];

      console.log("DTO recibido:", createDto);
      console.log("Parámetros enviados al SP:", parametros);

      // 4. Ejecución
      return await this.ordenRepo.query(query, parametros);

    } catch (error: any) { // Agregamos ': any' para solucionar el error de las capturas
      console.error("❌ Error al ejecutar SP_OrdenDiagnostico:");
      console.error("Mensaje:", error.message);
      
      // Si el error viene de SQL Server, TypeORM suele dar más detalles aquí
      throw new Error(error.message || "No se pudo guardar la orden en la base de datos");
    }
  }

  async findOne(id: number): Promise<OrdenDiagnostico> {
    const orden = await this.ordenRepo.findOne({
      where: { IdOrden: id },
      relations: ['cliente', 'equipo', 'prioridad']
    });

    if (!orden) {
      throw new NotFoundException(`La orden #${id} no existe`);
    }
    return orden;
  }

  findAll() {
    return this.ordenRepo.find({
      relations: ['cliente', 'equipo', 'prioridad']
    });
  }
}