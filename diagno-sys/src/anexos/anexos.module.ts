import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { MulterModule } from '@nestjs/platform-express';
import { AnexosService } from './anexos.service';
import { AnexosController } from './anexos.controller';
import { Anexo } from './entities/anexo.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([Anexo]),
    MulterModule.register({}),
  ],
  controllers: [AnexosController],
  providers: [AnexosService],
  exports: [AnexosService],
})
export class AnexosModule {}
