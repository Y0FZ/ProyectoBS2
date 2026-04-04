import { Controller, Get } from '@nestjs/common';
import { PrioridadService } from './prioridad.service';

@Controller('prioridad')
export class PrioridadController {
  constructor(private readonly prioridadService: PrioridadService) {}

  @Get()
  findAll() {
    // Este es el único método que necesitamos para llenar el select del HTML
    return this.prioridadService.findAll();
  }
}
