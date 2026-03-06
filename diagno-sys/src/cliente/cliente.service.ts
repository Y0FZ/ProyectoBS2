import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Cliente } from './entities/cliente.entity';

@Injectable()
export class ClienteService {
  constructor(
    @InjectRepository(Cliente)
    private readonly clienteRepository: Repository<Cliente>,
  ) {}

  // Usando tu SP: sp_IngresarCliente
  async create(dto: any) {
    const query = `EXEC sp_IngresarCliente @IdCliente='${dto.IdCliente}', @NombreCliente='${dto.NombreCliente}', @ApellidoCliente='${dto.ApellidoCliente}', @Telefono=${dto.Telefono}, @Correo='${dto.Correo}', @Direccion='${dto.Direccion}'`;
    return await this.clienteRepository.query(query);
  }

  async findAll() {
    return await this.clienteRepository.find();
  }

  async findOne(id: string) {
    return await this.clienteRepository.query(`EXEC sp_BuscarCliente @IdCliente='${id}'`);
  }

  async remove(id: string) {
    return await this.clienteRepository.query(`EXEC sp_BorrarCliente @IdCliente='${id}'`);
  }
}