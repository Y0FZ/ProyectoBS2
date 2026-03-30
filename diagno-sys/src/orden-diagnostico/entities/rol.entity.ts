import { Entity, Column, PrimaryColumn } from 'typeorm';

@Entity('Rol')
export class Rol {
  @PrimaryColumn()
  IdRol: number;

  @Column({ type: 'varchar', length: 15 })
  NombreRol: string;
}
