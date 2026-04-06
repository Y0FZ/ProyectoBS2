import { IsString, IsNumber, IsOptional } from 'class-validator';

export class CreateOrdenDiagnosticoDto {
  @IsNumber()
  IdOrden!: number;

  @IsString()
  @IsOptional()
  FechaRecepcion?: string; // Usamos string porque desde el input date llega como "YYYY-MM-DD"

  @IsString()
  @IsOptional()
  Descripcion?: string;

  @IsString()
  @IsOptional()
  EstadoArticulo?: string; // Nuevo: Para el estado físico (rayones, golpes, etc.)

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