import { Entity, Column, PrimaryColumn } from 'typeorm';

@Entity('EstadoOrden')
export class EstadoOrden {
  @PrimaryColumn()
  IdEstado!: number;

  @Column({ length: 50 })
  Estado!: string;
}