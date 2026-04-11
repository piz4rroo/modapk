import type { APIRoute } from 'astro';
import { getAllApps, createApp } from '../../../lib/apps';

export const GET: APIRoute = async () => {
  const apps = await getAllApps();
  return new Response(JSON.stringify({ apps }), {
    status: 200,
    headers: { 'Content-Type': 'application/json' },
  });
};

export const POST: APIRoute = async ({ request, cookies, redirect }) => {
  const token = cookies.get('admin_token')?.value;
  if (!token || token !== 'authenticated') {
    return redirect('/admin/login', 302);
  }

  const formData = await request.formData();

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

  const newApp = {
    slug: formData.get('slug')?.toString() ?? '',
    name: formData.get('name')?.toString() ?? '',
    category: formData.get('category')?.toString() ?? 'games',
    icon: formData.get('icon')?.toString() ?? '',
    version: formData.get('version')?.toString() ?? '',
    modInfo: formData.get('modInfo')?.toString() ?? '',
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
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  };

  await createApp(newApp);
  return redirect('/admin', 302);
};
