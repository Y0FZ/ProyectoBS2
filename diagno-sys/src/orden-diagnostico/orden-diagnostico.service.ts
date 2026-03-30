import { Injectable } from '@nestjs/common';
import { CreateOrdenDiagnosticoDto } from './dto/create-orden-diagnostico.dto';
import { UpdateOrdenDiagnosticoDto } from './dto/update-orden-diagnostico.dto';

@Injectable()
export class OrdenDiagnosticoService {
  create(createOrdenDiagnosticoDto: CreateOrdenDiagnosticoDto) {
    return 'This action adds a new ordenDiagnostico';
  }

  findAll() {
    return `This action returns all ordenDiagnostico`;
  }

  findOne(id: number) {
    return `This action returns a #${id} ordenDiagnostico`;
  }

  update(id: number, updateOrdenDiagnosticoDto: UpdateOrdenDiagnosticoDto) {
    return `This action updates a #${id} ordenDiagnostico`;
  }

  remove(id: number) {
    return `This action removes a #${id} ordenDiagnostico`;
  }
}
