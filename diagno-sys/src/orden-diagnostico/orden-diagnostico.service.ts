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

  async create(createDto: CreateOrdenDiagnosticoDto) { 
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