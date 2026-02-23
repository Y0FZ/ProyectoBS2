import { Entity, Column, PrimaryColumn } from 'typeorm';

@Entity('ArticuloEquipo')
export class ArticuloEquipo {
  @PrimaryColumn({ length: 30 })
  NumeroSerie: string;

  @Column({ length: 15 })
  TipoEquipo: string;

  @Column({ length: 10 })
  Marca: string;

  @Column({ length: 15 })
  Modelo: string;
}