import { Entity, Column, PrimaryColumn } from 'typeorm';

@Entity('Cliente') 
export class Cliente {
  @PrimaryColumn({ length: 12 })
  IdCliente: string;

  @Column({ length: 10 })
  NombreCliente: string;

  @Column({ length: 10 })
  ApellidoCliente: string;

  @Column()
  Telefono: number;

  @Column({ length: 20, nullable: true })
  Correo: string;

  @Column({ length: 20, nullable: true })
  Direccion: string;
}