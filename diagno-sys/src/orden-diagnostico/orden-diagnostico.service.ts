import { Injectable } from '@nestjs/common';
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

  async create(createDto: CreateOrdenDiagnosticoDto) {
    // Creamos la instancia mapeando los campos de tu SQL
    const nuevaOrden = this.ordenRepo.create({
      IdOrden: createDto.IdOrden,
      Descripcion: createDto.Descripcion,
      EstadoRecepcion: createDto.EstadoRecepcion,
      equipo: { NumeroSerie: createDto.SerieEquipo }, // Relación directa por ID
      cliente: { IdCliente: createDto.IdClienteD },   // Relación directa por ID
      prioridad: { IdPrioridad: createDto.Prioridad } // Relación directa por ID
    });

    return await this.ordenRepo.save(nuevaOrden);
  }

  findAll() {
    // Esto es para tu tabla de "Órdenes Recientes" en la web
    return this.ordenRepo.find({
      relations: ['cliente', 'equipo', 'prioridad']
    });
  }
}