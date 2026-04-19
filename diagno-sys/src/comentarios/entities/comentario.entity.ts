import { Entity, Column, PrimaryColumn, ManyToOne, JoinColumn } from 'typeorm';
import { EstadoOrden } from '../../estado-orden/entities/estado-orden.entity';
import { OrdenDiagnostico } from '../../orden-diagnostico/entities/orden-diagnostico.entity';
import { Anexo } from '../../anexos/entities/anexo.entity';

@Entity('Comentarios')
export class Comentario {
  @PrimaryColumn()
  IdComentario!: number;

  @Column({ length: 100 })
  Comentario!: string;

  @Column({ type: 'date' })
  FechaComentario!: Date;

  @Column({ name: 'IUsuario', length: 12 })  // Varchar(12) según SQL
  IUsuario!: string;

  @ManyToOne(() => EstadoOrden)
  @JoinColumn({ name: 'Estado' })
  estado!: EstadoOrden;

  @ManyToOne(() => OrdenDiagnostico)
  @JoinColumn({ name: 'IdDiagnostico' })
  orden!: OrdenDiagnostico;

  @ManyToOne(() => Anexo, { nullable: true, eager: false })
  @JoinColumn({ name: 'Anexos' })
  anexo?: Anexo;
}
