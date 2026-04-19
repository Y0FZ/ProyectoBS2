import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Comentario } from './entities/comentario.entity';
import { CreateComentarioDto } from './dto/create-comentario.dto';

@Injectable()
export class ComentariosService {
  constructor(
    @InjectRepository(Comentario)
    private readonly comentarioRepo: Repository<Comentario>,
  ) {}

  async create(createDto: CreateComentarioDto) {
    try {
      console.log('📥 Comentario recibido:', createDto);

      // INSERT directo con parámetros posicionales — igual que Usuario y Cliente
      // Evita que TypeORM falle al resolver las FKs con .save()
      if (createDto.Anexos) {
        await this.comentarioRepo.query(
          `INSERT INTO Comentarios
             (IdComentario, Comentario, FechaComentario, IUsuario, Estado, IdDiagnostico, Anexos)
           VALUES (@0, @1, @2, @3, @4, @5, @6)`,
          [
            createDto.IdComentario,
            createDto.Comentario,
            createDto.FechaComentario,
            createDto.IUsuario,
            createDto.Estado,
            createDto.IdDiagnostico,
            createDto.Anexos,
          ],
        );
      } else {
        await this.comentarioRepo.query(
          `INSERT INTO Comentarios
             (IdComentario, Comentario, FechaComentario, IUsuario, Estado, IdDiagnostico)
           VALUES (@0, @1, @2, @3, @4, @5)`,
          [
            createDto.IdComentario,
            createDto.Comentario,
            createDto.FechaComentario,
            createDto.IUsuario,
            createDto.Estado,
            createDto.IdDiagnostico,
          ],
        );
      }

      console.log('✅ Comentario insertado:', createDto.IdComentario);
      return { ...createDto };

    } catch (error: any) {
      console.error('❌ Error en Comentarios:', error.message);
      throw new Error(error.message || 'No se pudo registrar el comentario');
    }
  }

  async findByOrden(idOrden: number): Promise<any[]> {
    return this.comentarioRepo.query(
      `SELECT c.IdComentario, c.Comentario, c.FechaComentario, c.IUsuario,
              e.IdEstado, e.Estado AS EstadoNombre,
              a.IdAnexos, a.RutaArchivo
       FROM Comentarios c
       INNER JOIN EstadoOrden e ON e.IdEstado = c.Estado
       LEFT  JOIN Anexos      a ON a.IdAnexos  = c.Anexos
       WHERE c.IdDiagnostico = @0
       ORDER BY c.FechaComentario DESC, c.IdComentario DESC`,
      [idOrden],
    );
  }

  async findAll(idDiagnostico?: number): Promise<any[]> {
    if (idDiagnostico) return this.findByOrden(idDiagnostico);
    return this.comentarioRepo.query(
      `SELECT c.IdComentario, c.Comentario, c.FechaComentario, c.IUsuario,
              e.IdEstado, e.Estado AS EstadoNombre,
              a.IdAnexos, a.RutaArchivo
       FROM Comentarios c
       INNER JOIN EstadoOrden e ON e.IdEstado = c.Estado
       LEFT  JOIN Anexos      a ON a.IdAnexos  = c.Anexos
       ORDER BY c.FechaComentario DESC, c.IdComentario DESC`,
    );
  }
}
