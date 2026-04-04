import { Entity, Column, PrimaryColumn, ManyToOne, JoinColumn, CreateDateColumn } from 'typeorm';
import { ArticuloEquipo } from '../../articulo-equipo/entities/articulo-equipo.entity';
import { Cliente } from '../../cliente/entities/cliente.entity';
import { Prioridad } from '../../prioridad/entities/prioridad.entity';

@Entity('OrdenDiagnostico')
export class OrdenDiagnostico {
  @PrimaryColumn()
  IdOrden!: number;

  @CreateDateColumn({ name: 'FechaCreacion', type: 'date' })
  FechaCreacion!: Date;

  @Column({ length: 100, nullable: true })
  Descripcion!: string; string;

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