import { IsString, IsInt, IsOptional, MaxLength } from 'class-validator';
import { Type } from 'class-transformer';

export class CreateAnexoDto {
  @IsInt()
  @Type(() => Number)
  IdAnexos!: number;

  @IsString()
  @MaxLength(500)
  RutaArchivo!: string;

  @IsString()
  @IsOptional()
  @MaxLength(255)
  NombreArchivo?: string;

  @IsString()
  @IsOptional()
  @MaxLength(100)
  TipoArchivo?: string;

  @IsOptional()          // No llega desde el frontend — el service pone la fecha
  FechaSubida?: string;
}
