import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Anexo } from './entities/anexo.entity';
import { CreateAnexoDto } from './dto/create-anexo.dto';

@Injectable()
export class AnexosService {
  constructor(
    @InjectRepository(Anexo)
    private readonly anexoRepo: Repository<Anexo>,
  ) {}

  async create(createAnexoDto: CreateAnexoDto): Promise<Anexo> {
    const nuevo = this.anexoRepo.create({
      IdAnexos:      createAnexoDto.IdAnexos,
      RutaArchivo:   createAnexoDto.RutaArchivo,
      NombreArchivo: createAnexoDto.NombreArchivo,
      TipoArchivo:   createAnexoDto.TipoArchivo,
      FechaSubida:   createAnexoDto.FechaSubida
                      ? new Date(createAnexoDto.FechaSubida)
                      : new Date(),
    });
    return this.anexoRepo.save(nuevo);
  }

  findAll(): Promise<Anexo[]> {
    return this.anexoRepo.find();
  }

  findOne(id: number): Promise<Anexo | null> {
    return this.anexoRepo.findOneBy({ IdAnexos: id });
  }

  async remove(id: number): Promise<void> {
    await this.anexoRepo.delete(id);
  }
}
