import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { OrdenDiagnostico } from './entities/orden-diagnostico.entity';

@Module({
  imports: [TypeOrmModule.forFeature([OrdenDiagnostico])],
  exports: [TypeOrmModule],
})
export class OrdenDiagnosticoModule {}