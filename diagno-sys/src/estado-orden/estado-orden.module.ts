import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { EstadoOrdenService } from './estado-orden.service';
import { EstadoOrdenController } from './estado-orden.controller';
import { EstadoOrden } from './entities/estado-orden.entity';

@Module({
  imports: [TypeOrmModule.forFeature([EstadoOrden])],
  controllers: [EstadoOrdenController],
  providers: [EstadoOrdenService],
  exports: [EstadoOrdenService],
})
export class EstadoOrdenModule {}