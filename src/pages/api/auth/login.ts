import type { APIRoute } from 'astro';

export const POST: APIRoute = async ({ request, cookies, redirect }) => {
  const formData = await request.formData();
  const password = formData.get('password')?.toString() ?? '';

  const adminPassword = import.meta.env.ADMIN_PASSWORD ?? 'admin123';

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
