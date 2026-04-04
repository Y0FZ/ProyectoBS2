import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { EstadoOrden } from './entities/estado-orden.entity';

@Module({
  imports: [TypeOrmModule.forFeature([EstadoOrden])],
  exports: [TypeOrmModule],
})
export class EstadoOrdenModule {}