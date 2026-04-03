import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';
import { SupabaseService } from './supabase/supabase.service';
import { DataSource } from 'typeorm';

@Controller()
export class AppController {
  constructor(
    private readonly appService: AppService,
    private readonly supabaseService: SupabaseService,
    private readonly dataSource: DataSource,
  ) {}

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }

  @Get('health')
  async checkHealth() {
    const supabaseTest = await this.supabaseService.testConnection();
    let dbStatus = 'Disconnected';
    
    try {
      if (this.dataSource.isInitialized) {
        // Simple query to verify DB connection
        await this.dataSource.query('SELECT 1');
        dbStatus = 'Connected';
      }
    } catch (err) {
      dbStatus = `Error: ${err.message}`;
    }

    return {
      status: 'OK',
      database: dbStatus,
      supabaseAPI: supabaseTest.success ? 'Connected' : `Error: ${supabaseTest.message}`,
    };
  }
}
