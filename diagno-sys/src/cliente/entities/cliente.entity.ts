import { Entity, Column, PrimaryColumn } from 'typeorm';

@Entity('Cliente') 
export class Cliente {
  @PrimaryColumn({ length: 12 })
  IdCliente: string;

  @Column({ type: 'varchar', length: 10 })
  NombreCliente: string;

  @Column({ type: 'varchar', length: 10 })
  ApellidoCliente: string;

  @Column({ type: 'int' })
  Telefono: number;

  @Column({ type: 'varchar', length: 20, nullable: true })
  Correo: string;

  @Column({ type: 'varchar', length: 20, nullable: true })
  Direccion: string;
}