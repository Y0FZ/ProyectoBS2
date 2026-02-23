import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { ArticuloEquipo } from './entities/articulo-equipo.entity';

@Injectable()
export class ArticuloEquipoService {
  constructor(
    @InjectRepository(ArticuloEquipo)
    private readonly articuloRepository: Repository<ArticuloEquipo>,
  ) {}

  async create(dto: any) {
    return await this.articuloRepository.save(dto);
  }

  async findAll() {
    return await this.articuloRepository.find();
  }

  async findOne(id: string) {
    return await this.articuloRepository.findOneBy({ NumeroSerie: id });
  }

  async update(id: string, dto: any) {
    await this.articuloRepository.update(id, dto);
    return this.findOne(id);
  }

  async remove(id: string) {
    await this.articuloRepository.delete(id);
    return { deleted: true };
  }
}