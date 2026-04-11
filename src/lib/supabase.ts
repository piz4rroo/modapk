import { createClient } from '@supabase/supabase-js';

const supabaseUrl = import.meta.env.SUPABASE_URL || process.env.SUPABASE_URL || '';
const supabaseAnonKey = import.meta.env.SUPABASE_ANON_KEY || process.env.SUPABASE_ANON_KEY || '';

if (!supabaseUrl || !supabaseAnonKey) {
  console.error('WARNING: Missing SUPABASE_URL or SUPABASE_ANON_KEY environment variables');
  console.error('SUPABASE_URL set:', !!supabaseUrl);
  console.error('SUPABASE_ANON_KEY set:', !!supabaseAnonKey);
}

export const supabase = createClient(supabaseUrl || 'https://placeholder.supabase.co', supabaseAnonKey || 'placeholder');
