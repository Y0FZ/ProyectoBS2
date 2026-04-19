import { IsString, IsInt, IsOptional, MaxLength } from 'class-validator';
import { Type } from 'class-transformer';

export class CreateComentarioDto {
  @IsInt()
  @Type(() => Number)
  IdComentario!: number;

  @IsString()
  @MaxLength(100)
  Comentario!: string;

  @IsString()
  FechaComentario!: string;   // Llega como "YYYY-MM-DD" desde el frontend

  @IsString()
  @MaxLength(12)              // Varchar(12) → references Usuario(IdUsuarios)
  IUsuario!: string;

  @IsInt()
  @Type(() => Number)
  Estado!: number;            // FK → EstadoOrden(IdEstado)

  @IsInt()
  @Type(() => Number)
  IdDiagnostico!: number;     // FK → OrdenDiagnostico(IdOrden)

  @IsInt()
  @IsOptional()
  @Type(() => Number)
  Anexos?: number;            // FK → Anexos(IdAnexos), nullable
}
