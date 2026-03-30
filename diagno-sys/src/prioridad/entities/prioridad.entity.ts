import { Entity, Column, PrimaryColumn } from 'typeorm';

@Entity('Prioridad')
export class Prioridad {
  @PrimaryColumn()
  IdPrioridad: number;

  @Column({ type: 'varchar', length: 10, nullable: true })
  NivelPrioridad: string;
}
