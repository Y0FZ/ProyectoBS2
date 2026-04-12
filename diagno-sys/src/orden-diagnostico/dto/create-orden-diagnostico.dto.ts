import { IsString, IsNumber, IsOptional } from 'class-validator';

export class CreateOrdenDiagnosticoDto {
  @IsNumber()
  IdOrden!: number;

  @IsString()
  @IsOptional()
  FechaCreacion?: Date; // Usamos string porque desde el input date llega como "YYYY-MM-DD"

  @IsString()
  @IsOptional()
  Descripcion?: string;

  @IsString()
  @IsOptional()
  EstadoRecepcion?: string; // Para el estado del proceso (ej: "Recibido en Taller")

  @IsString()
  SerieEquipo!: string;

  @IsString()
  IdClienteD!: string;

  @IsNumber()
  Prioridad!: number;
}