import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Usuario } from './entities/usuario.entity';

@Injectable()
export class UsuarioService {
  constructor(
    @InjectRepository(Usuario)
    private readonly usuarioRepository: Repository<Usuario>,
  ) {}

  // Usamos INSERT directo porque el SP sp_IgresarUsuario no acepta IdRol
  // y TypeORM.save() falla por la constraint de FK en IdRol
  async create(dto: any) {
    return await this.usuarioRepository.query(
      `INSERT INTO Usuario (IdUsuarios, NombreUsuario, Contrasena, IdRol)
       VALUES (@0, @1, @2, @3)`,
      [dto.IdUsuarios, dto.NombreUsuario, dto.Contrasena, dto.IdRol],
    );
  }

  async findAll() {
    return await this.usuarioRepository.find({ relations: ['RolRel'] });
  }

  async findOne(id: string) {
    return await this.usuarioRepository.findOne({
      where: { IdUsuarios: id },
      relations: ['RolRel'],
    });
  }

  async update(id: string, dto: any) {
    // Si no se envía contraseña nueva, no la tocamos
    if (dto.Contrasena) {
      return await this.usuarioRepository.query(
        `UPDATE Usuario SET NombreUsuario = @0, Contrasena = @1, IdRol = @2
         WHERE IdUsuarios = @3`,
        [dto.NombreUsuario, dto.Contrasena, dto.IdRol, id],
      );
    } else {
      return await this.usuarioRepository.query(
        `UPDATE Usuario SET NombreUsuario = @0, IdRol = @1
         WHERE IdUsuarios = @2`,
        [dto.NombreUsuario, dto.IdRol, id],
      );
    }
  }

  async validateUser(id: string, pass: string): Promise<any> {
    const usuario = await this.usuarioRepository.findOne({
      where: { IdUsuarios: id },
      relations: ['RolRel'],
    });

    if (usuario && usuario.Contrasena === pass) {
      const { Contrasena, ...result } = usuario;
      return {
        ...result,
        IdRol: usuario.RolRel ? usuario.RolRel.IdRol : null,
        NombreRol: usuario.RolRel ? usuario.RolRel.NombreRol : 'Sin Rol',
      };
    }
    return null;
  }

  async remove(id: string) {
    return await this.usuarioRepository.delete(id);
  }
}