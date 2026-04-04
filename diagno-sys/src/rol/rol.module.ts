import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Rol } from './entities/rol.entity';
import { RolService } from './rol.service';
import { RolController } from './rol.controller';

@Module({
  controllers: [RolController],
  providers: [RolService],
  imports: [TypeOrmModule.forFeature([Rol])], // <--- ESTO ES VITAL
  exports: [TypeOrmModule]
})
export class RolModule {}
