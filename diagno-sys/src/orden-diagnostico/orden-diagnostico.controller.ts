import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { OrdenDiagnosticoService } from './orden-diagnostico.service';
import { CreateOrdenDiagnosticoDto } from './dto/create-orden-diagnostico.dto';
import { UpdateOrdenDiagnosticoDto } from './dto/update-orden-diagnostico.dto';



@Controller('orden-diagnostico')
export class OrdenDiagnosticoController {
  constructor(private readonly ordenDiagnosticoService: OrdenDiagnosticoService) {}

  @Post()
  create(@Body() createOrdenDiagnosticoDto: CreateOrdenDiagnosticoDto) {
    return this.ordenDiagnosticoService.create(createOrdenDiagnosticoDto);
  }

  @Get()
  findAll() {
    return this.ordenDiagnosticoService.findAll();
  }

  @Get('proximo-id')
  getProximoId() {
    console.log("Solicitando próximo ID...");
    return this.ordenDiagnosticoService.findLastId();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
      return this.ordenDiagnosticoService.findOne(+id);
  }

  //@Patch(':id')
  //update(@Param('id') id: string, @Body() updateOrdenDiagnosticoDto: UpdateOrdenDiagnosticoDto) {
  //  return this.ordenDiagnosticoService.update(+id, updateOrdenDiagnosticoDto);
  //}

  //@Delete(':id')
  //remove(@Param('id') id: string) {
  //  return this.ordenDiagnosticoService.remove(+id);
  //}
}
