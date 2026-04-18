import { supabase } from './supabase';

// ---- TRACKING (client-callable via API) ----

export async function trackPageView(pagePath: string, appSlug?: string) {
  const row: Record<string, any> = { page_path: pagePath };
  if (appSlug) row.app_slug = appSlug;
  
  const { error } = await supabase.from('page_views').insert(row);
  if (error) console.error('Error tracking page view:', error.message);
}

export async function trackDownload(appSlug: string, versionLabel?: string) {
  const row: Record<string, any> = { app_slug: appSlug };
  if (versionLabel) row.version_label = versionLabel;
  
  const { error } = await supabase.from('download_events').insert(row);
  if (error) console.error('Error tracking download:', error.message);
}

// ---- ANALYTICS QUERIES (admin only) ----

export interface DashboardStats {
  totalApps: number;
  totalDownloads: number;
  totalPageViews: number;
  todayPageViews: number;
  monthPageViews: number;
  todayDownloads: number;
  monthDownloads: number;
}

export async function getDashboardStats(totalApps: number): Promise<DashboardStats> {
  const now = new Date();
  const todayStart = new Date(now.getFullYear(), now.getMonth(), now.getDate()).toISOString();
  const monthStart = new Date(now.getFullYear(), now.getMonth(), 1).toISOString();

  // Total downloads
  const { count: totalDownloads } = await supabase
    .from('download_events')
    .select('*', { count: 'exact', head: true });

  // Total page views
  const { count: totalPageViews } = await supabase
    .from('page_views')
    .select('*', { count: 'exact', head: true });

  // Today's page views
  const { count: todayPageViews } = await supabase
    .from('page_views')
    .select('*', { count: 'exact', head: true })
    .gte('created_at', todayStart);

  // This month's page views
  const { count: monthPageViews } = await supabase
    .from('page_views')
    .select('*', { count: 'exact', head: true })
    .gte('created_at', monthStart);

  // Today's downloads
  const { count: todayDownloads } = await supabase
    .from('download_events')
    .select('*', { count: 'exact', head: true })
    .gte('created_at', todayStart);

  // This month's downloads
  const { count: monthDownloads } = await supabase
    .from('download_events')
    .select('*', { count: 'exact', head: true })
    .gte('created_at', monthStart);

  return {
    totalApps,
    totalDownloads: totalDownloads || 0,
    totalPageViews: totalPageViews || 0,
    todayPageViews: todayPageViews || 0,
    monthPageViews: monthPageViews || 0,
    todayDownloads: todayDownloads || 0,
    monthDownloads: monthDownloads || 0,
  };
}

export interface AppDownloadStats {
  app_slug: string;
  download_count: number;
}

export async function getTopDownloadedApps(limit = 10): Promise<AppDownloadStats[]> {
  // We need to do a manual count since Supabase JS doesn't support GROUP BY directly
  const { data, error } = await supabase
    .from('download_events')
    .select('app_slug');

  if (error || !data) return [];

  // Count downloads per app
  const counts: Record<string, number> = {};
  for (const row of data) {
    counts[row.app_slug] = (counts[row.app_slug] || 0) + 1;
  }

  return Object.entries(counts)
    .map(([app_slug, download_count]) => ({ app_slug, download_count }))
    .sort((a, b) => b.download_count - a.download_count)
    .slice(0, limit);
}

export async function getAppViewCount(appSlug: string): Promise<number> {
  const { count } = await supabase
    .from('page_views')
    .select('*', { count: 'exact', head: true })
    .eq('app_slug', appSlug);
  
  return count || 0;
}

export async function getAppDownloadCount(appSlug: string): Promise<number> {
  const { count } = await supabase
    .from('download_events')
    .select('*', { count: 'exact', head: true })
    .eq('app_slug', appSlug);
  
  return count || 0;
}
