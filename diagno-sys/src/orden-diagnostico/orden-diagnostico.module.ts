import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { OrdenDiagnosticoService } from './orden-diagnostico.service'; // AGREGAR
import { OrdenDiagnosticoController } from './orden-diagnostico.controller'; // AGREGAR
import { OrdenDiagnostico } from './entities/orden-diagnostico.entity';

@Module({
  imports: [TypeOrmModule.forFeature([OrdenDiagnostico])],
  controllers: [OrdenDiagnosticoController], // <--- ESTO FALTABA
  providers: [OrdenDiagnosticoService],       // <--- ESTO FALTABA
  exports: [OrdenDiagnosticoService],
})
export class OrdenDiagnosticoModule {}