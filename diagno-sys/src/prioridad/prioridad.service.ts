import { Injectable } from '@nestjs/common';
import { CreatePrioridadDto } from './dto/create-prioridad.dto';
import { UpdatePrioridadDto } from './dto/update-prioridad.dto';
import { InjectRepository } from '@nestjs/typeorm'; 
import { Repository } from 'typeorm';              
import { Prioridad } from './entities/prioridad.entity';

@Injectable()
export class PrioridadService {
  constructor(
    @InjectRepository(Prioridad)
    private readonly repo: Repository<Prioridad>,
  ) {}

  findAll() {
    return this.repo.find(); // Trae Urgente, Alta, Media, Baja desde SQL
  }

  findOne(id: number) {
    return `This action returns a #${id} prioridad`;
  }

  update(id: number, updatePrioridadDto: UpdatePrioridadDto) {
    return `This action updates a #${id} prioridad`;
  }

  remove(id: number) {
    return `This action removes a #${id} prioridad`;
  }
}
