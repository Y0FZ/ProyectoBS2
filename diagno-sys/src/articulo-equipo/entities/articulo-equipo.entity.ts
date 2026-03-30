import { Entity, Column, PrimaryColumn } from 'typeorm';

@Entity('ArticuloEquipo')
export class ArticuloEquipo {
  @PrimaryColumn({ length: 30 })
  NumeroSerie: string;

  @Column({ type: 'varchar', length: 15 })
  TipoEquipo: string;

  @Column({ type: 'varchar', length: 10 })
  Marca: string;

  @Column({ type: 'varchar', length: 15 })
  Modelo: string;
}