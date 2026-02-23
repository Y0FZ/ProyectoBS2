import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ClienteModule } from './cliente/cliente.module';
import { Cliente } from './cliente/entities/cliente.entity';
import { ArticuloEquipoModule } from './articulo-equipo/articulo-equipo.module';
import { ArticuloEquipo } from './articulo-equipo/entities/articulo-equipo.entity';


@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'mssql',
      host: '127.0.0.1',
      port: 1433,
      username: 'sa',
      password: '1234',
      database: 'DiagnoSysBD', // Nombre según tu script SQL
      entities: [Cliente, ArticuloEquipo],
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
  ],
})
export class AppModule {}