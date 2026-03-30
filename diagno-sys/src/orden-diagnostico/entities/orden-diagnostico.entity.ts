import { Entity, Column, PrimaryColumn, ManyToOne, JoinColumn } from 'typeorm';
import { ArticuloEquipo } from '../../articulo-equipo/entities/articulo-equipo.entity';
import { Cliente } from '../../cliente/entities/cliente.entity';
import { Prioridad } from '../../prioridad/entities/prioridad.entity';

@Entity('OrdenDiagnostico')
export class OrdenDiagnostico {
  @PrimaryColumn()
  IdOrden: number;

  @Column({ type: 'date', default: () => 'GETDATE()' })
  FechaCreacion: Date;

  @Column({ type: 'varchar', length: 100, nullable: true })
  Descripcion: string;

  @Column({ type: 'varchar', length: 50, nullable: true })
  EstadoRecepcion: string;

  @Column({ type: 'varchar', length: 30 })
  SerieEquipo: string;

  @ManyToOne(() => ArticuloEquipo)
  @JoinColumn({ name: 'SerieEquipo' })
  EquipoRel: ArticuloEquipo;

  @Column({ type: 'varchar', length: 12 })
  IdClienteD: string;

  @ManyToOne(() => Cliente)
  @JoinColumn({ name: 'IdClienteD' })
  ClienteRel: Cliente;

  @Column({ type: 'int' })
  Prioridad: number;

  @ManyToOne(() => Prioridad)
  @JoinColumn({ name: 'Prioridad' })
  PrioridadRel: Prioridad;
}
