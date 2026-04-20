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

  // Devuelve el siguiente IdComentario disponible (autoincremento manual)
  async findLastId(): Promise<number> {
    try {
      const [row] = await this.comentarioRepo.query(
        `SELECT ISNULL(MAX(IdComentario), 0) + 1 AS siguiente FROM Comentarios`,
      );
      return Number(row.siguiente);
    } catch {
      return Date.now() % 999999 + 1;
    }
  }

  async create(createDto: CreateComentarioDto) {
    try {
      console.log('📥 Comentario recibido:', createDto);

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
              u.NombreUsuario, r.NombreRol,
              a.IdAnexos, a.RutaArchivo
       FROM Comentarios c
       INNER JOIN EstadoOrden e ON e.IdEstado  = c.Estado
       LEFT  JOIN Usuario     u ON u.IdUsuarios = c.IUsuario
       LEFT  JOIN Rol         r ON r.IdRol      = u.IdRol
       LEFT  JOIN Anexos      a ON a.IdAnexos   = c.Anexos
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
              u.NombreUsuario, r.NombreRol,
              a.IdAnexos, a.RutaArchivo
       FROM Comentarios c
       INNER JOIN EstadoOrden e ON e.IdEstado  = c.Estado
       LEFT  JOIN Usuario     u ON u.IdUsuarios = c.IUsuario
       LEFT  JOIN Rol         r ON r.IdRol      = u.IdRol
       LEFT  JOIN Anexos      a ON a.IdAnexos   = c.Anexos
       ORDER BY c.FechaComentario DESC, c.IdComentario DESC`,
    );
  }
}
