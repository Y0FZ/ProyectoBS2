import { PartialType } from '@nestjs/mapped-types';
import { CreateArticuloEquipoDto } from './create-articulo-equipo.dto';

export class UpdateArticuloEquipoDto extends PartialType(CreateArticuloEquipoDto) {}
