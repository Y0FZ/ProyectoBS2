import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ArticuloEquipoService } from './articulo-equipo.service';
import { ArticuloEquipoController } from './articulo-equipo.controller';
import { ArticuloEquipo } from './entities/articulo-equipo.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([ArticuloEquipo])
  ],
  controllers: [ArticuloEquipoController],
  providers: [ArticuloEquipoService],
})
export class ArticuloEquipoModule {}