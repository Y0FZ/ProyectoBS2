import { Test, TestingModule } from '@nestjs/testing';
import { OrdenDiagnosticoService } from './orden-diagnostico.service';

describe('OrdenDiagnosticoService', () => {
  let service: OrdenDiagnosticoService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [OrdenDiagnosticoService],
    }).compile();

    service = module.get<OrdenDiagnosticoService>(OrdenDiagnosticoService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
