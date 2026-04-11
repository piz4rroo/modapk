import { supabase } from './supabase';

// Type for app as used in the frontend (camelCase)
export interface AppVersion {
  label: string;
  version: string;
  size: string;
  downloadUrl: string;
  modType: string;
  isLatest: boolean;
}

export interface App {
  id?: string;
  slug: string;
  name: string;
  category: string;
  icon: string;
  version: string;
  modInfo: string;
  size: string;
  rating: number;
  developer: string;
  requires: string;
  downloadUrl: string;
  shortDescription: string;
  fullDescription: string;
  modFeatures: string[];
  screenshots: string[];
  versions: AppVersion[];
  createdAt: string;
  updatedAt: string;
}

// Convert DB row (snake_case) to App (camelCase)
function toApp(row: any): App {
  return {
    id: row.id,
    slug: row.slug,
    name: row.name,
    category: row.category,
    icon: row.icon || '',
    version: row.version || '',
    modInfo: row.mod_info || '',
    size: row.size || '',
    rating: parseFloat(row.rating) || 0,
    developer: row.developer || '',
    requires: row.requires || '',
    downloadUrl: row.download_url || '',
    shortDescription: row.short_description || '',
    fullDescription: row.full_description || '',
    modFeatures: row.mod_features || [],
    screenshots: row.screenshots || [],
    versions: row.versions || [],
    createdAt: row.created_at || '',
    updatedAt: row.updated_at || '',
  };
}

// Convert App (camelCase) to DB row (snake_case) for insert/update
function toRow(app: Partial<App>): Record<string, any> {
  const row: Record<string, any> = {};
  if (app.slug !== undefined) row.slug = app.slug;
  if (app.name !== undefined) row.name = app.name;
  if (app.category !== undefined) row.category = app.category;
  if (app.icon !== undefined) row.icon = app.icon;
  if (app.version !== undefined) row.version = app.version;
  if (app.modInfo !== undefined) row.mod_info = app.modInfo;
  if (app.size !== undefined) row.size = app.size;
  if (app.rating !== undefined) row.rating = app.rating;
  if (app.developer !== undefined) row.developer = app.developer;
  if (app.requires !== undefined) row.requires = app.requires;
  if (app.downloadUrl !== undefined) row.download_url = app.downloadUrl;
  if (app.shortDescription !== undefined) row.short_description = app.shortDescription;
  if (app.fullDescription !== undefined) row.full_description = app.fullDescription;
  if (app.modFeatures !== undefined) row.mod_features = app.modFeatures;
  if (app.screenshots !== undefined) row.screenshots = app.screenshots;
  if (app.versions !== undefined) row.versions = app.versions;
  if (app.updatedAt !== undefined) row.updated_at = app.updatedAt;
  if (app.createdAt !== undefined) row.created_at = app.createdAt;
  return row;
}

// ---- READ operations ----

export async function getAllApps(): Promise<App[]> {
  const { data, error } = await supabase
    .from('apps')
    .select('*')
    .order('updated_at', { ascending: false });

  if (error) {
    console.error('Error fetching apps:', error.message);
    return [];
  }
  return (data || []).map(toApp);
}

export async function getAppBySlug(slug: string): Promise<App | null> {
  const { data, error } = await supabase
    .from('apps')
    .select('*')
    .eq('slug', slug)
    .single();

  if (error || !data) return null;
  return toApp(data);
}

export async function getAppsByCategory(category: string): Promise<App[]> {
  const { data, error } = await supabase
    .from('apps')
    .select('*')
    .eq('category', category)
    .order('updated_at', { ascending: false });

  if (error) {
    console.error('Error fetching apps by category:', error.message);
    return [];
  }
  return (data || []).map(toApp);
}

// ---- WRITE operations ----

export async function createApp(app: Omit<App, 'id'>): Promise<App | null> {
  const row = toRow(app);
  row.created_at = new Date().toISOString();
  row.updated_at = new Date().toISOString();

  const { data, error } = await supabase
    .from('apps')
    .insert(row)
    .select()
    .single();

  if (error) {
    console.error('Error creating app:', error.message);
    return null;
  }
  return toApp(data);
}

export async function updateApp(slug: string, app: Partial<App>): Promise<App | null> {
  const row = toRow(app);
  row.updated_at = new Date().toISOString();

  const { data, error } = await supabase
    .from('apps')
    .update(row)
    .eq('slug', slug)
    .select()
    .single();

  if (error) {
    console.error('Error updating app:', error.message);
    return null;
  }
  return toApp(data);
}

export async function deleteApp(slug: string): Promise<boolean> {
  const { error } = await supabase
    .from('apps')
    .delete()
    .eq('slug', slug);

  if (error) {
    console.error('Error deleting app:', error.message);
    return false;
  }
  return true;
}
