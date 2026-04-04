import { NestFactory } from '@nestjs/core';
import { ValidationPipe } from '@nestjs/common';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  
  // Esto activa la validación automática de tus DTOs
  app.useGlobalPipes(new ValidationPipe());
  
  app.enableCors();
  await app.listen(3000);
}
bootstrap();