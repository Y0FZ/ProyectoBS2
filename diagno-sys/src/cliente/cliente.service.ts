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

  async create(dto: any) {
    const query = `EXEC sp_IngresarCliente @IdCliente='${dto.IdCliente}', @NombreCliente='${dto.NombreCliente}', @ApellidoCliente='${dto.ApellidoCliente}', @Telefono=${dto.Telefono}, @Correo='${dto.Correo || ''}', @Direccion='${dto.Direccion || ''}'`;
    return await this.clienteRepository.query(query);
  }

  async findAll() {
    return await this.clienteRepository.find();
  }

  async findOne(id: string) {
    return await this.clienteRepository.query(`EXEC sp_BuscarCliente @IdCliente='${id}'`);
  }

  // El SP sp_ModificarCliente tiene un bug: compara todos los campos ANTES de actualizar,
  // por eso nunca actualiza. Usamos UPDATE directo que es más confiable.
  async update(id: string, dto: any) {
    return await this.clienteRepository.query(
      `UPDATE Cliente SET 
        NombreCliente   = @0,
        ApellidoCliente = @1,
        Telefono        = @2,
        Correo          = @3,
        Direccion       = @4
       WHERE IdCliente  = @5`,
      [
        dto.NombreCliente,
        dto.ApellidoCliente,
        dto.Telefono,
        dto.Correo    || '',
        dto.Direccion || '',
        id,
      ],
    );
  }

  async remove(id: string) {
    return await this.clienteRepository.query(`EXEC sp_BorrarCliente @IdCliente='${id}'`);
  }
}