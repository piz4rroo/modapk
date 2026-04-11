import type { APIRoute } from 'astro';

export const GET: APIRoute = async () => {
  const fromImportMeta = import.meta.env.ADMIN_PASSWORD;
  const fromProcessEnv = process.env.ADMIN_PASSWORD;
  return new Response(JSON.stringify({
    importMeta: typeof fromImportMeta + ': ' + (fromImportMeta ? '[SET]' : '[EMPTY]'),
    processEnv: typeof fromProcessEnv + ': ' + (fromProcessEnv ? '[SET]' : '[EMPTY]'),
    fallbackUsed: !fromImportMeta && !fromProcessEnv,
  }), { headers: { 'Content-Type': 'application/json' } });
};

export const POST: APIRoute = async ({ request, cookies, redirect }) => {
  const formData = await request.formData();
  const password = formData.get('password')?.toString() ?? '';

  const adminPassword = import.meta.env.ADMIN_PASSWORD || process.env.ADMIN_PASSWORD || 'admin123';

  if (password === adminPassword) {
    cookies.set('admin_token', 'authenticated', {
      httpOnly: true,
      path: '/',
      maxAge: 86400,
    });
    return redirect('/admin', 302);
  }

  return redirect('/admin/login?error=1', 302);
};
