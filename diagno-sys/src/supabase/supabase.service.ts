import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { createClient, SupabaseClient } from '@supabase/supabase-js';

@Injectable()
export class SupabaseService {
  private supabase: SupabaseClient;

  constructor(private configService: ConfigService) {
    const supabaseUrl = this.configService.get<string>('SUPABASE_URL');
    const supabaseKey = this.configService.get<string>('SUPABASE_ANON_KEY');

    if (!supabaseUrl || !supabaseKey) {
      throw new Error('Supabase credentials are missing in environment variables');
    }

    this.supabase = createClient(supabaseUrl, supabaseKey);
  }

  getClient(): SupabaseClient {
    return this.supabase;
  }

  async testConnection(): Promise<{ success: boolean; message: string }> {
    try {
      // Intentamos una operación simple para verificar la conectividad
      const { data, error } = await this.supabase.from('_test_connection').select('*').limit(1);
      
      // Si el error es 'PGRST116' (tabla no existe), la conexión es válida pero la tabla no.
      // Si hay un error de red o de credenciales, 'error' no será nulo.
      if (error && error.code !== 'PGRST116') {
        return { success: false, message: error.message };
      }
      
      return { success: true, message: 'Conectado exitosamente a Supabase API' };
    } catch (err) {
      return { success: false, message: err.message };
    }
  }
}
