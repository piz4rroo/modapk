import type { APIRoute } from 'astro';
import { trackPageView } from '../../../lib/analytics';

export const POST: APIRoute = async ({ request }) => {
  try {
    const body = await request.json();
    const { path, appSlug } = body;
    
    if (!path) {
      return new Response(JSON.stringify({ error: 'path is required' }), { status: 400 });
    }

    await trackPageView(path, appSlug || undefined);
    return new Response(JSON.stringify({ ok: true }), { status: 200 });
  } catch {
    return new Response(JSON.stringify({ error: 'Invalid request' }), { status: 400 });
  }
};
