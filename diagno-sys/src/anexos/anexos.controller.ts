import { Controller, Get, Post, Body, Param, Delete } from '@nestjs/common';
import { AnexosService } from './anexos.service';
import { CreateAnexoDto } from './dto/create-anexo.dto';

@Controller('anexos')
export class AnexosController {
  constructor(private readonly anexosService: AnexosService) {}

  @Post()
  create(@Body() createAnexoDto: CreateAnexoDto) {
    return this.anexosService.create(createAnexoDto);
  }

  @Get()
  findAll() {
    return this.anexosService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.anexosService.findOne(+id);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.anexosService.remove(+id);
  }
}
