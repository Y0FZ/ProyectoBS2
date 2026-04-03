import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { ClienteModule } from './cliente/cliente.module';
import { ArticuloEquipoModule } from './articulo-equipo/articulo-equipo.module';
import { UsuarioModule } from './usuario/usuario.module';
import { OrdenDiagnosticoModule } from './orden-diagnostico/orden-diagnostico.module';
import { PrioridadModule } from './prioridad/prioridad.module';
import { RolModule } from './rol/rol.module';
import { SupabaseModule } from './supabase/supabase.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    TypeOrmModule.forRootAsync({
      imports: [ConfigModule],
      inject: [ConfigService],
      useFactory: (configService: ConfigService) => ({
        type: 'postgres',
        host: configService.get<string>('DB_HOST'),
        port: configService.get<number>('DB_PORT'),
        username: configService.get<string>('DB_USER'),
        password: configService.get<string>('DB_PASS'),
        database: configService.get<string>('DB_NAME'),
        autoLoadEntities: true,
        synchronize: false, // Set to true only in development and with caution
        ssl: {
          rejectUnauthorized: false, // Required for Supabase connections
        },
      }),
    }),
    SupabaseModule,
    ClienteModule,
    ArticuloEquipoModule,
    UsuarioModule,
    OrdenDiagnosticoModule,
    PrioridadModule,
    RolModule,
  ],
})
export class AppModule {}