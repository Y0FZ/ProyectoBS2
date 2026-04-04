import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateUsuarioDto } from './dto/create-usuario.dto';
import { UpdateUsuarioDto } from './dto/update-usuario.dto';
import { Usuario } from './entities/usuario.entity';

@Injectable()
export class UsuarioService {
  constructor(
    @InjectRepository(Usuario)
    private readonly usuarioRepository: Repository<Usuario>,
  ) {}

  create(createUsuarioDto: CreateUsuarioDto) {
    const nuevo = this.usuarioRepository.create(createUsuarioDto);
    return this.usuarioRepository.save(nuevo);
  }

  findAll() {
    return this.usuarioRepository.find({ relations: ['RolRel'] });
  }

  findOne(id: string) {
    return this.usuarioRepository.findOne({ where: { IdUsuarios: id }, relations: ['RolRel'] });
  }

  async validateUser(id: string, pass: string): Promise<any> {
  const usuario = await this.usuarioRepository.findOne({
    where: { IdUsuarios: id },
    relations: ['RolRel'], // Esto fuerza a TypeORM a traer los datos del Rol
  });

  if (usuario && usuario.Contrasena === pass) {
    // Al incluir RolRel, ahora tienes acceso a usuario.RolRel.IdRol y usuario.RolRel.NombreRol
    const { Contrasena, ...result } = usuario;
    return {
      ...result,
      IdRol: usuario.RolRel ? usuario.RolRel.IdRol : null,
      NombreRol: usuario.RolRel ? usuario.RolRel.NombreRol : 'Sin Rol'
    };
  }
  return null;
}

  remove(id: string) {
    return this.usuarioRepository.delete(id);
  }
}
