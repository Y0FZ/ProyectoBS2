import { Entity, Column, PrimaryColumn } from 'typeorm';

@Entity('Rol')
export class Rol {
  @PrimaryColumn({ type: 'int' })
  IdRol: number;

  @Column({ type: 'varchar', length: 15 })
  NombreRol: string;
}