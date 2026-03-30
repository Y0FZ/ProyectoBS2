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

  async update(id: string, updateUsuarioDto: UpdateUsuarioDto) {
    await this.usuarioRepository.update(id, updateUsuarioDto);
    return this.findOne(id);
  }

  remove(id: string) {
    return this.usuarioRepository.delete(id);
  }
}
