import { Entity, Column, PrimaryColumn, ManyToOne, JoinColumn } from 'typeorm';
import { ArticuloEquipo } from '../../articulo-equipo/entities/articulo-equipo.entity';
import { Cliente } from '../../cliente/entities/cliente.entity';
import { Prioridad } from '../../prioridad/entities/prioridad.entity';

@Entity('OrdenDiagnostico')
export class OrdenDiagnostico {
  @PrimaryColumn()
  IdOrden!: number;

  @Column({ name: 'FechaCreacion', type: 'date', nullable: false }) 
  FechaCreacion!: string;

  @Column({ length: 200, nullable: true })
  Descripcion!: string;

  @Column({ length: 50, nullable: true })
  EstadoRecepcion!: string;

  // RELACIONES EXACTAS
  @ManyToOne(() => ArticuloEquipo)
  @JoinColumn({ name: 'SerieEquipo' }) // Columna en SQL
  equipo!: ArticuloEquipo;

  @ManyToOne(() => Cliente)
  @JoinColumn({ name: 'IdClienteD' }) // Columna en SQL
  cliente!: Cliente;

  @ManyToOne(() => Prioridad)
  @JoinColumn({ name: 'Prioridad' }) // Columna en SQL
  prioridad!: Prioridad;
}