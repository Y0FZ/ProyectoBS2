import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ClienteModule } from './cliente/cliente.module';
import { Cliente } from './cliente/entities/cliente.entity';
import { ArticuloEquipoModule } from './articulo-equipo/articulo-equipo.module';
import { ArticuloEquipo } from './articulo-equipo/entities/articulo-equipo.entity';
import { UsuarioModule } from './usuario/usuario.module';
import { OrdenDiagnosticoModule } from './orden-diagnostico/orden-diagnostico.module';
import { PrioridadModule } from './prioridad/prioridad.module';
import { RolModule } from './rol/rol.module';
import { Usuario } from './usuario/entities/usuario.entity';
import { Rol } from './rol/entities/rol.entity';
import { Prioridad } from './prioridad/entities/prioridad.entity';
import { OrdenDiagnostico } from './orden-diagnostico/entities/orden-diagnostico.entity';
import { EstadoOrden } from './estado-orden/entities/estado-orden.entity';
import { EstadoOrdenModule } from './estado-orden/estado-orden.module';
import { ComentariosModule } from './comentarios/comentarios.module';
import { AnexosModule } from './anexos/anexos.module';
import { Comentario } from './comentarios/entities/comentario.entity';
import { Anexo } from './anexos/entities/anexo.entity';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'mssql',
      host: '127.0.0.1',
      port: 1433,
      username: 'sa',
      password: '1234',
      database: 'DiagnoSysBD',
      entities: [
        Cliente,
        ArticuloEquipo,
        Usuario,
        Rol,
        Prioridad,
        OrdenDiagnostico,
        EstadoOrden,
        Comentario,   // ← agregado
        Anexo,        // ← agregado
      ],
      synchronize: false,
      autoLoadEntities: true,
      options: {
        encrypt: false,
        trustServerCertificate: true,
      },
      extra: {
        pool: {
          max: 1,
          min: 0,
          idleTimeoutMillis: 30000,
        },
      },
    }),
    ClienteModule,
    ArticuloEquipoModule,
    UsuarioModule,
    OrdenDiagnosticoModule,
    PrioridadModule,
    RolModule,
    EstadoOrdenModule,
    ComentariosModule,
    AnexosModule,
  ],
})
export class AppModule {}
