import { PartialType } from '@nestjs/mapped-types';
import { CreateOrdenDiagnosticoDto } from './create-orden-diagnostico.dto';

export class UpdateOrdenDiagnosticoDto extends PartialType(CreateOrdenDiagnosticoDto) {}
