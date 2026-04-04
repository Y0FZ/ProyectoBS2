import { Entity, Column, PrimaryColumn } from 'typeorm';

@Entity('Prioridad')
export class Prioridad {
  @PrimaryColumn()
  IdPrioridad: number;

  @Column({ length: 10 })
  NivelPrioridad: string;
}