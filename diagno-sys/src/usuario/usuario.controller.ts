import { Controller, Get, Post, Body, Param, Delete, UnauthorizedException } from '@nestjs/common';
import { UsuarioService } from './usuario.service';
import { CreateUsuarioDto } from './dto/create-usuario.dto';
import { UpdateUsuarioDto } from './dto/update-usuario.dto';


@Controller('usuario')
export class UsuarioController {
  constructor(private readonly usuarioService: UsuarioService) {}

  @Post()
  create(@Body() createUsuarioDto: CreateUsuarioDto) {
    return this.usuarioService.create(createUsuarioDto);
  }

  @Get()
  findAll() {
    return this.usuarioService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.usuarioService.findOne(id);
  }

  //@Patch(':id')
  //update(@Param('id') id: string, @Body() updateUsuarioDto: UpdateUsuarioDto) {
  //  return this.usuarioService.update(id, updateUsuarioDto);
  //}

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.usuarioService.remove(id);
  }

  @Post('login')
  async login(@Body() loginDto: { id: string; pass: string }) {
  const user = await this.usuarioService.validateUser(loginDto.id, loginDto.pass);
  if (!user) {
    throw new UnauthorizedException('Credenciales inválidas');
  }
  return user; // Retorna el objeto con IdRol
}

}
