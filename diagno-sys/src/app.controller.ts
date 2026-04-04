import { Controller, Get } from '@nestjs/common';
import { PrioridadService } from './prioridad/prioridad.service'; // Se agrega /prioridad/

@Controller('prioridad')
export class PrioridadController {
  constructor(private readonly prioridadService: PrioridadService) {}

  @Get()
  findAll() {
    return this.prioridadService.findAll();
  }
  
}
