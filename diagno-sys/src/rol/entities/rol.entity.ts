import { Entity, Column, PrimaryColumn, OneToMany } from 'typeorm';
import { Usuario } from '../../usuario/entities/usuario.entity';

@Entity('Rol') // Asegúrate que este sea el nombre exacto de la tabla en SQL Server
export class Rol {
  @PrimaryColumn()
  IdRol!: number;

  @Column({ length: 50 })
  NombreRol!: string;

  // Esta parte es opcional pero ayuda a que la relación sea bidireccional
  @OneToMany(() => Usuario, (usuario) => usuario.RolRel)
  usuarios!: Usuario[];
}