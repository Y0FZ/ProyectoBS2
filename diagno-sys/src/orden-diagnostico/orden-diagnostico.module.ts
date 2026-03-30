import { Module } from '@nestjs/common';
import { OrdenDiagnosticoService } from './orden-diagnostico.service';
import { OrdenDiagnosticoController } from './orden-diagnostico.controller';

@Module({
  controllers: [OrdenDiagnosticoController],
  providers: [OrdenDiagnosticoService],
})
export class OrdenDiagnosticoModule {}
