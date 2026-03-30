import { Test, TestingModule } from '@nestjs/testing';
import { OrdenDiagnosticoController } from './orden-diagnostico.controller';
import { OrdenDiagnosticoService } from './orden-diagnostico.service';

describe('OrdenDiagnosticoController', () => {
  let controller: OrdenDiagnosticoController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [OrdenDiagnosticoController],
      providers: [OrdenDiagnosticoService],
    }).compile();

    controller = module.get<OrdenDiagnosticoController>(OrdenDiagnosticoController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
