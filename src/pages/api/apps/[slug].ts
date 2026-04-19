import type { APIRoute } from 'astro';
import { getAppBySlug, updateApp, deleteApp } from '../../../lib/apps';
import { getAuthUser } from '../../../lib/auth';

export const GET: APIRoute = async ({ params }) => {
  const app = await getAppBySlug(params.slug || '');
  if (!app) {
    return new Response(JSON.stringify({ error: 'Not found' }), { status: 404 });
  }
  return new Response(JSON.stringify(app), {
    status: 200,
    headers: { 'Content-Type': 'application/json' },
  });
};

export const POST: APIRoute = async ({ params, request, cookies, redirect }) => {
  const user = await getAuthUser(cookies);
  if (!user) {
    return redirect('/admin/login', 302);
  }

  const formData = await request.formData();
  const method = formData.get('_method')?.toString();
  const slug = params.slug || '';

  if (method === 'DELETE') {
    await deleteApp(slug);
    return redirect('/admin/apps', 302);
  }

  // UPDATE
  const modFeaturesRaw = formData.get('modFeatures')?.toString() ?? '';
  const screenshotsRaw = formData.get('screenshots')?.toString() ?? '';
  const versionsRaw = formData.get('versions')?.toString() ?? '';

  const versions = versionsRaw.split('\n').map(s => s.trim()).filter(Boolean).map(line => {
    const parts = line.split('|');
    return {
      label: parts[0] || '',
      version: parts[1] || '',
      size: parts[2] || '',
      downloadUrl: parts[3] || '',
      modType: parts[4] || 'Full Mod',
      isLatest: parts[5] === 'true',
    };
  });

  const updatedApp = {
    slug: formData.get('slug')?.toString() ?? slug,
    name: formData.get('name')?.toString() ?? '',
    category: formData.get('category')?.toString() ?? 'games',
    icon: formData.get('icon')?.toString() ?? '',
    version: formData.get('version')?.toString() ?? '',
    size: formData.get('size')?.toString() ?? '',
    rating: parseFloat(formData.get('rating')?.toString() ?? '0'),
    developer: formData.get('developer')?.toString() ?? '',
    requires: formData.get('requires')?.toString() ?? '',
    downloadUrl: formData.get('downloadUrl')?.toString() ?? '',
    shortDescription: formData.get('shortDescription')?.toString() ?? '',
    fullDescription: formData.get('fullDescription')?.toString() ?? '',
    modFeatures: modFeaturesRaw.split('\n').map(s => s.trim()).filter(Boolean),
    screenshots: screenshotsRaw.split('\n').map(s => s.trim()).filter(Boolean),
    versions,
    updatedAt: new Date().toISOString(),
  };

  await updateApp(slug, updatedApp);
  return redirect('/admin/apps', 302);
};
