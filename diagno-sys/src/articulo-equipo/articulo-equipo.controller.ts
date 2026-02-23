import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { ArticuloEquipoService } from './articulo-equipo.service';

@Controller('articulo-equipo')
export class ArticuloEquipoController {
  constructor(private readonly articuloEquipoService: ArticuloEquipoService) {}

  @Post()
  create(@Body() createDto: any) {
    return this.articuloEquipoService.create(createDto);
  }

  @Get()
  findAll() {
    return this.articuloEquipoService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.articuloEquipoService.findOne(id); // <--- Quitamos el +
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateDto: any) {
    return this.articuloEquipoService.update(id, updateDto); // <--- Quitamos el +
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.articuloEquipoService.remove(id); // <--- Quitamos el +
  }
}