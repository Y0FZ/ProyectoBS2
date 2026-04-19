import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { EstadoOrden } from './entities/estado-orden.entity';

@Injectable()
export class EstadoOrdenService {
  constructor(
    @InjectRepository(EstadoOrden)
    private readonly estadoRepo: Repository<EstadoOrden>,
  ) {}

  findAll(): Promise<EstadoOrden[]> {
    return this.estadoRepo.find({ order: { IdEstado: 'ASC' } });
  }

  findOne(id: number): Promise<EstadoOrden | null> {
    return this.estadoRepo.findOne({ where: { IdEstado: id } });
  }
}
