import { IsString, IsNumber, IsOptional } from 'class-validator';

export class CreateOrdenDiagnosticoDto {
  @IsNumber()
  IdOrden!: number;

  @IsOptional()
  @IsString()
  Descripcion?: string;

  @IsOptional()
  @IsString()
  EstadoRecepcion?: string;

  @IsString()
  SerieEquipo!: string;

  @IsString()
  IdClienteD!: string;

  @IsNumber()
  Prioridad!: number;
}