import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { OrdenDiagnostico } from './entities/orden-diagnostico.entity';

@Injectable()
export class OrdenDiagnosticoService {
  constructor(
    @InjectRepository(OrdenDiagnostico)
    private readonly ordenRepo: Repository<OrdenDiagnostico>,
  ) {}

  async findLastId(): Promise<number> {
    try {
      const ultimaOrden = await this.ordenRepo.find({
        select: ['IdOrden'],
        order: { IdOrden: 'DESC' } as any,
        take: 1,
      });
      return ultimaOrden.length > 0 ? Number(ultimaOrden[0].IdOrden) + 1 : 1;
    } catch (error) {
      console.error('Error en el contador:', error);
      return 1;
    }
  }

  async create(createDto: any) {
    try {
      if (!createDto.SerieEquipo || !createDto.IdClienteD) {
        throw new Error('Faltan datos obligatorios (Serie o Cliente)');
      }

      console.log('DTO recibido:', createDto);

      // INSERT directo con parámetros posicionales (igual que Usuario y Cliente)
      // Evita dependencia del SP sp_IgresarOrdenDiagnostico
      const result = await this.ordenRepo.query(
        `INSERT INTO OrdenDiagnostico
           (IdOrden, FechaCreacion, Descripcion, EstadoRecepcion, SerieEquipo, IdClienteD, Prioridad)
         VALUES (@0, @1, @2, @3, @4, @5, @6)`,
        [
          createDto.IdOrden,
          createDto.FechaCreacion,
          createDto.Descripcion     || 'Sin descripción',
          createDto.EstadoRecepcion || 'No especificado',
          createDto.SerieEquipo,
          createDto.IdClienteD,
          createDto.Prioridad,
        ],
      );

      console.log('✅ Orden insertada:', createDto.IdOrden);

      // Devolver el objeto con IdOrden para que el frontend pueda mostrar el ticket
      return { IdOrden: createDto.IdOrden, ...createDto };

    } catch (error: any) {
      console.error('❌ Error al insertar OrdenDiagnostico:', error.message);
      throw new Error(error.message || 'No se pudo guardar la orden');
    }
  }

  async findOne(id: number): Promise<OrdenDiagnostico> {
    const orden = await this.ordenRepo.findOne({
      where: { IdOrden: id },
      relations: ['cliente', 'equipo', 'prioridad'],
    });
    if (!orden) throw new NotFoundException(`La orden #${id} no existe`);
    return orden;
  }

  async findAll(): Promise<any[]> {
    const ordenes = await this.ordenRepo.find({
      relations: ['cliente', 'equipo', 'prioridad'],
      order: { IdOrden: 'DESC' } as any,
    });

    const ordenesConEstado = await Promise.all(
      ordenes.map(async (o) => {
        const [ultimoComentario] = await this.ordenRepo.query(
          `SELECT TOP 1 c.FechaComentario, e.Estado, c.IUsuario
           FROM Comentarios c
           INNER JOIN EstadoOrden e ON e.IdEstado = c.Estado
           WHERE c.IdDiagnostico = @0
           ORDER BY c.FechaComentario DESC, c.IdComentario DESC`,
          [o.IdOrden],
        );

        return {
          ...o,
          EstadoActual:        ultimoComentario?.Estado          ?? 'Recibida',
          FechaUltimoEstado:   ultimoComentario?.FechaComentario ?? null,
          UsuarioUltimoEstado: ultimoComentario?.IUsuario        ?? null,
        };
      }),
    );

    return ordenesConEstado;
  }
}
