import { Entity, Column, PrimaryColumn, ManyToOne, JoinColumn } from 'typeorm';
import { ArticuloEquipo } from '../../articulo-equipo/entities/articulo-equipo.entity';
import { Cliente } from '../../cliente/entities/cliente.entity';
import { Prioridad } from '../../prioridad/entities/prioridad.entity';

@Entity('OrdenDiagnostico')
export class OrdenDiagnostico {
  @PrimaryColumn()
  IdOrden!: number;

  // En el código usas 'FechaRecepcion', pero en SQL se guardará como 'FechaCreacion'
  @Column({ name: 'FechaCreacion', type: 'date', nullable: true }) 
  FechaRecepcion!: string;

  @Column({ length: 500, nullable: true })
  Descripcion!: string;

  // En el código usas 'EstadoArticulo', que es lo que espera tu DTO y tu HTML
  @Column({ length: 500, nullable: true })
  EstadoArticulo!: string;

  @Column({ length: 50, nullable: true })
  EstadoRecepcion!: string;

  @ManyToOne(() => ArticuloEquipo)
  @JoinColumn({ name: 'SerieEquipo' })
  equipo!: ArticuloEquipo;

  @ManyToOne(() => Cliente)
  @JoinColumn({ name: 'IdClienteD' })
  cliente!: Cliente;

  @ManyToOne(() => Prioridad)
  @JoinColumn({ name: 'Prioridad' })
  prioridad!: Prioridad;
}