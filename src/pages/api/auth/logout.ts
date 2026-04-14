import type { APIRoute } from 'astro';
import { supabase } from '../../../lib/supabase';
import { clearAuthCookies } from '../../../lib/auth';

export const POST: APIRoute = async ({ cookies }) => {
  await supabase.auth.signOut();
  clearAuthCookies(cookies);

  return new Response(
    JSON.stringify({ success: true }),
    { status: 200, headers: { 'Content-Type': 'application/json' } }
  );
};
