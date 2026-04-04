import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm'; // <--- Importante
import { PrioridadService } from './prioridad.service';
import { PrioridadController } from './prioridad.controller';
import { Prioridad } from './entities/prioridad.entity'; // <--- Importante

@Module({
  // Esta es la línea que le falta a tu código:
  imports: [TypeOrmModule.forFeature([Prioridad])], 
  controllers: [PrioridadController],
  providers: [PrioridadService],
  exports: [PrioridadService] // Opcional, por si lo usas en otro módulo
})
export class PrioridadModule {}