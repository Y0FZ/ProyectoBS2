import { Entity, Column, PrimaryColumn } from 'typeorm';

@Entity('Anexos')
export class Anexo {
  @PrimaryColumn()
  IdAnexos!: number;

  @Column({ name: 'RutaArchivo', length: 500 })
  RutaArchivo!: string;

  @Column({ name: 'NombreArchivo', length: 255, nullable: true })
  NombreArchivo?: string;

  @Column({ name: 'TipoArchivo', length: 100, nullable: true })
  TipoArchivo?: string;

  @Column({ name: 'FechaSubida', type: 'date', nullable: true })
  FechaSubida?: Date;
}
