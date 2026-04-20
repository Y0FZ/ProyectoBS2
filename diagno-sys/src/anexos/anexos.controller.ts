import {
  Controller, Get, Post, Body, Param, Delete,
  UploadedFile, UseInterceptors, BadRequestException,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { diskStorage } from 'multer';
import { extname, join } from 'path';
import { AnexosService } from './anexos.service';
import { CreateAnexoDto } from './dto/create-anexo.dto';

@Controller('anexos')
export class AnexosController {
  constructor(private readonly anexosService: AnexosService) {}

  // POST /anexos/upload  ← sube el archivo físico y devuelve la URL pública
  @Post('upload')
  @UseInterceptors(
    FileInterceptor('file', {
      storage: diskStorage({
        destination: join(process.cwd(), 'uploads'),
        filename: (_req, file, cb) => {
          const unique = Date.now() + '-' + Math.round(Math.random() * 1e6);
          cb(null, unique + extname(file.originalname));
        },
      }),
      limits: { fileSize: 20 * 1024 * 1024 }, // 20 MB máx
    }),
  )
  uploadFile(@UploadedFile() file: any) {
    if (!file) throw new BadRequestException('No se recibió ningún archivo');
    return {
      originalName: file.originalname,
      filename: file.filename,
      url: `http://localhost:3000/uploads/${file.filename}`,
    };
  }

  @Post()
  create(@Body() createAnexoDto: CreateAnexoDto) {
    return this.anexosService.create(createAnexoDto);
  }

  // GET /anexos/proximo-id  ← para IDs secuenciales
  @Get('proximo-id')
  getProximoId() {
    return this.anexosService.findLastId();
  }

  @Get()
  findAll() {
    return this.anexosService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.anexosService.findOne(+id);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.anexosService.remove(+id);
  }
}