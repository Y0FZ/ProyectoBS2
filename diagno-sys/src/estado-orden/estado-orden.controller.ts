import { Controller, Get, Param } from '@nestjs/common';
import { EstadoOrdenService } from './estado-orden.service';
 
@Controller('estado-orden')
export class EstadoOrdenController {
  constructor(private readonly estadoOrdenService: EstadoOrdenService) {}
 
  @Get()
  findAll() {
    return this.estadoOrdenService.findAll();
  }
 
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.estadoOrdenService.findOne(+id);
  }
}
 
