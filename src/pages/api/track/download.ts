import type { APIRoute } from 'astro';
import { trackDownload } from '../../../lib/analytics';

export const POST: APIRoute = async ({ request }) => {
  try {
    const body = await request.json();
    const { appSlug, versionLabel } = body;
    
    if (!appSlug) {
      return new Response(JSON.stringify({ error: 'appSlug is required' }), { status: 400 });
    }

    await trackDownload(appSlug, versionLabel || undefined);
    return new Response(JSON.stringify({ ok: true }), { status: 200 });
  } catch {
    return new Response(JSON.stringify({ error: 'Invalid request' }), { status: 400 });
  }
};
