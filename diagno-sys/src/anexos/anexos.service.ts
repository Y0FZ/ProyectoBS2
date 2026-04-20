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

  // Devuelve el siguiente IdAnexos disponible (autoincremento manual)
  async findLastId(): Promise<number> {
    try {
      const [row] = await this.anexoRepo.query(
        `SELECT ISNULL(MAX(IdAnexos), 0) + 1 AS siguiente FROM Anexos`,
      );
      return Number(row.siguiente);
    } catch {
      return Date.now() % 999999 + 2;
    }
  }

  async create(createAnexoDto: CreateAnexoDto): Promise<any> {
    try {
      console.log('📥 Anexo recibido:', createAnexoDto);

      await this.anexoRepo.query(
        `INSERT INTO Anexos (IdAnexos, RutaArchivo)
         VALUES (@0, @1)`,
        [
          createAnexoDto.IdAnexos,
          createAnexoDto.RutaArchivo,
        ],
      );

      console.log('✅ Anexo insertado:', createAnexoDto.IdAnexos);
      return { IdAnexos: createAnexoDto.IdAnexos, RutaArchivo: createAnexoDto.RutaArchivo };

    } catch (error: any) {
      console.error('❌ Error en Anexos:', error.message);
      throw new Error(error.message || 'No se pudo registrar el anexo');
    }
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
