import { Controller, Get, Post, Body, Param, Query } from '@nestjs/common';
import { ComentariosService } from './comentarios.service';
import { CreateComentarioDto } from './dto/create-comentario.dto';

@Controller('comentarios')
export class ComentariosController {
  constructor(private readonly comentariosService: ComentariosService) {}

  @Post()
  create(@Body() createComentarioDto: CreateComentarioDto) {
    return this.comentariosService.create(createComentarioDto);
  }

  // GET /comentarios  o  GET /comentarios?idDiagnostico=5
  @Get()
  findAll(@Query('idDiagnostico') idDiagnostico?: string) {
    return this.comentariosService.findAll(
      idDiagnostico ? parseInt(idDiagnostico) : undefined,
    );
  }

  // GET /comentarios/orden/5
  @Get('orden/:id')
  findByOrden(@Param('id') id: string) {
    return this.comentariosService.findByOrden(+id);
  }
}
