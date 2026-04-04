import { Entity, Column, PrimaryColumn, ManyToOne, JoinColumn } from 'typeorm';
import { Rol } from '../../rol/entities/rol.entity';

@Entity('Usuario')
export class Usuario {
  @PrimaryColumn({ length: 12 })
  IdUsuarios!: string;

  @Column({ type: 'varchar', length: 20 })
  NombreUsuario!: string;

  @Column({ type: 'varchar', length: 20 })
  Contrasena!: string;

  @Column({ type: 'int' })
  IdRol!: number;

  @ManyToOne(() => Rol, (rol) => rol.IdRol)
  @JoinColumn({ name: 'IdRol' }) 
  RolRel!: Rol;
}