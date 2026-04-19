import { IsString, IsNumber, IsOptional, MaxLength } from 'class-validator';

export class CreateAnexoDto {
  @IsNumber()
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

  @IsOptional()
  FechaSubida?: Date;
}
