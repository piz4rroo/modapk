-- ============================================================
-- ModVault Supabase Seed SQL
-- Generated from data/apps.json
-- ============================================================

-- 1. CREATE TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS apps (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  slug TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  category TEXT NOT NULL DEFAULT 'games',
  icon TEXT DEFAULT '',
  version TEXT DEFAULT '',
  mod_info TEXT DEFAULT '',
  size TEXT DEFAULT '',
  rating NUMERIC(2,1) DEFAULT 0,
  developer TEXT DEFAULT '',
  requires TEXT DEFAULT '',
  download_url TEXT DEFAULT '',
  short_description TEXT DEFAULT '',
  full_description TEXT DEFAULT '',
  mod_features TEXT[] DEFAULT '{}',
  screenshots TEXT[] DEFAULT '{}',
  versions JSONB DEFAULT '[]',
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 2. RLS POLICIES
-- ============================================================
ALTER TABLE apps ENABLE ROW LEVEL SECURITY;

-- Allow public read access to all apps
CREATE POLICY "Allow public read access"
  ON apps
  FOR SELECT
  TO anon, authenticated
  USING (true);

-- Allow authenticated users to insert apps
CREATE POLICY "Allow authenticated insert"
  ON apps
  FOR INSERT
  TO authenticated
  WITH CHECK (true);

-- Allow authenticated users to update apps
CREATE POLICY "Allow authenticated update"
  ON apps
  FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- Allow authenticated users to delete apps
CREATE POLICY "Allow authenticated delete"
  ON apps
  FOR DELETE
  TO authenticated
  USING (true);

-- 3. INSERT ALL APPS
-- ============================================================

INSERT INTO apps (
  slug, name, category, icon, version, mod_info, size, rating,
  developer, requires, download_url, short_description, full_description,
  mod_features, screenshots, versions, created_at, updated_at
) VALUES

-- App 1: Clash of Clans
(
  'clash-of-clans-mod',
  'Clash of Clans',
  'games',
  '/icons/clash-of-clans.webp',
  '16.386.14',
  'Unlimited Gems, Gold & Elixir',
  '280MB',
  4.7,
  'Supercell',
  'Android 5.0+',
  'https://mega.nz/file/example-coc',
  'Build your village, raise a clan, and compete in epic Clan Wars with unlimited gems and resources.',
  E'Clash of Clans is a freemium mobile strategy game developed and published by Supercell. The game is set in a fantasy-themed persistent world where the player is a chief of a village. In this modded version, you get unlimited gems, gold, and elixir to build and upgrade your base without any restrictions.\r\n\r\nWith this mod, you can instantly upgrade all buildings, troops, and heroes to their maximum level. Train the most powerful armies and dominate Clan Wars without spending a single real dollar. The mod also includes a private server option so your progress is safe and secure.\r\n\r\nAll features work on the latest version and are regularly updated to stay compatible with new game updates. Join millions of players worldwide and experience Clash of Clans the way it was meant to be played \u2014 without limits.',
  ARRAY['Unlimited Gems', 'Unlimited Gold', 'Unlimited Elixir', 'Unlimited Dark Elixir', 'Instant Troop Training', 'Max Level Heroes', 'Private Server Included', 'Anti-Ban Protection'],
  ARRAY['/screenshots/clash-of-clans/screen1.webp', '/screenshots/clash-of-clans/screen2.webp', '/screenshots/clash-of-clans/screen3.webp', '/screenshots/clash-of-clans/screen4.webp'],
  '[{"label": "v16.386.14 (Latest)", "version": "16.386.14", "size": "280MB", "downloadUrl": "https://mega.nz/file/example-coc-latest", "modType": "Full Mod", "isLatest": true}, {"label": "v16.253.20 (Stable)", "version": "16.253.20", "size": "265MB", "downloadUrl": "https://mega.nz/file/example-coc-stable", "modType": "Full Mod", "isLatest": false}, {"label": "v15.547.8 (Lite)", "version": "15.547.8", "size": "150MB", "downloadUrl": "https://mega.nz/file/example-coc-lite", "modType": "Lite Mod", "isLatest": false}]'::jsonb,
  '2025-11-10T08:00:00Z'::timestamptz,
  '2026-04-10T13:40:51.258Z'::timestamptz
),

-- App 2: PUBG Mobile
(
  'pubg-mobile-mod',
  'PUBG Mobile',
  'games',
  '/icons/pubg-mobile.webp',
  '3.5.0',
  'Anti-Ban + Free UC + ESP',
  '1.1GB',
  4.5,
  'Tencent Games',
  'Android 6.0+',
  'https://mega.nz/file/example-pubg',
  'Drop into intense battle royale matches with anti-ban protection, free UC, and advanced ESP features.',
  E'PUBG Mobile is the original battle royale game that started it all on mobile. Drop onto a massive 8x8 km map with 99 other players and fight to be the last one standing. This modded version gives you a serious competitive edge with features that are undetectable by the game''s anti-cheat system.\n\nThe mod includes a built-in ESP (Extra Sensory Perception) that lets you see enemy positions, loot locations, and vehicle spawns through walls. You also get free UC (Unknown Cash) to purchase premium skins, outfits, and weapon crates from the in-game store without spending real money.\n\nOur anti-ban system uses advanced encryption and spoofing techniques to keep your account safe. The mod is updated within 24 hours of every official game update to maintain compatibility and security. Works on both global and regional versions of PUBG Mobile.',
  ARRAY['Anti-Ban Protection', 'Free UC (Unknown Cash)', 'ESP / Wall Hack', 'Aimbot with Adjustable FOV', 'No Recoil', 'Auto Headshot', 'Speed Hack', 'High Jump'],
  ARRAY['/screenshots/pubg-mobile/screen1.webp', '/screenshots/pubg-mobile/screen2.webp', '/screenshots/pubg-mobile/screen3.webp', '/screenshots/pubg-mobile/screen4.webp'],
  '[{"label": "v3.5.0 (Latest)", "version": "3.5.0", "size": "1.1GB", "downloadUrl": "https://mega.nz/file/example-pubg-latest", "modType": "Full Mod", "isLatest": true}, {"label": "v3.4.0 (Stable)", "version": "3.4.0", "size": "1.0GB", "downloadUrl": "https://mega.nz/file/example-pubg-stable", "modType": "Full Mod", "isLatest": false}, {"label": "v3.3.1 (Lite)", "version": "3.3.1", "size": "680MB", "downloadUrl": "https://mega.nz/file/example-pubg-lite", "modType": "Lite Mod", "isLatest": false}]'::jsonb,
  '2025-12-01T10:00:00Z'::timestamptz,
  '2026-03-15T18:45:00Z'::timestamptz
),

-- App 3: Instagram
(
  'instagram-mod',
  'Instagram',
  'social',
  '/icons/instagram.webp',
  '348.0.0.0.64',
  'No Ads + Story Download + Ghost Mode',
  '72MB',
  4.6,
  'Meta Platforms',
  'Android 7.0+',
  'https://mega.nz/file/example-instagram',
  'Browse Instagram without ads, download any content, and use ghost mode to view stories anonymously.',
  E'Instagram is the world''s leading photo and video sharing social network with over 2 billion monthly active users. This modded version removes all advertisements and adds powerful features that aren''t available in the official app.\n\nDownload any photo, video, reel, or story directly to your device with a single tap. The built-in ghost mode lets you view stories and live streams without the other person knowing. You can also disable read receipts in DMs, hide your online status, and prevent others from seeing when you''re typing.\n\nAdditional features include the ability to zoom into profile pictures in full HD, copy comments and bios, use multiple accounts simultaneously, and customize the app''s theme. The mod is based on the latest official Instagram release and receives regular updates.',
  ARRAY['No Advertisements', 'Download Photos, Videos & Reels', 'Download Stories Anonymously', 'Ghost Mode (Stealth Viewing)', 'Disable Read Receipts', 'Hide Online Status', 'Zoom Profile Pictures (Full HD)', 'Custom Themes Support'],
  ARRAY['/screenshots/instagram/screen1.webp', '/screenshots/instagram/screen2.webp', '/screenshots/instagram/screen3.webp', '/screenshots/instagram/screen4.webp'],
  '[{"label": "v348.0.0.0.64 (Latest)", "version": "348.0.0.0.64", "size": "72MB", "downloadUrl": "https://mega.nz/file/example-instagram-latest", "modType": "Full Mod", "isLatest": true}, {"label": "v345.0.0.0.86 (Stable)", "version": "345.0.0.0.86", "size": "70MB", "downloadUrl": "https://mega.nz/file/example-instagram-stable", "modType": "Full Mod", "isLatest": false}, {"label": "v340.0.0.0.92 (Clone)", "version": "340.0.0.0.92", "size": "68MB", "downloadUrl": "https://mega.nz/file/example-instagram-clone", "modType": "Clone Mod", "isLatest": false}]'::jsonb,
  '2025-09-20T15:00:00Z'::timestamptz,
  '2026-04-05T11:20:00Z'::timestamptz
),

-- App 4: Minecraft
(
  'minecraft-mod',
  'Minecraft',
  'games',
  'https://play-lh.googleusercontent.com/27O5tpaYE82W6m30rJ_MX3-UvshlDM6O8oXDxb6GseYW2T7P8UNT19727MGmz-0q3w=s96-rw',
  '1.21.60.27',
  'Unlocked + God Mode + All Skins Free',
  '230MB',
  4.9,
  'Mojang Studios',
  'Android 5.0+',
  'https://mcpedl.org/uploads_files/02-03-2026/minecraft-26-3.apk',
  'Explore infinite worlds and build everything from simple homes to grand castles with god mode and all content unlocked.',
  E'Minecraft is the best-selling video game of all time, offering players an infinite world of creativity and adventure. This modded version unlocks the full premium game for free and adds powerful gameplay enhancements that transform your experience.\r\n\r\nGod mode makes you invincible \u2014 no mob, fall, or lava can kill you. All skins, texture packs, and marketplace content are unlocked for free, giving you access to thousands of dollars worth of premium content. You also get unlimited items in creative mode and enhanced tools in survival mode.\r\n\r\nThe mod supports both single-player and multiplayer gameplay, including Realms and custom servers. It''s fully compatible with the latest Bedrock Edition features including the new biomes, mobs, and crafting recipes. Regular updates ensure you always have access to the newest content.',
  ARRAY['Full Game Unlocked (Premium Free)', 'God Mode (Invincibility)', 'All Skins Unlocked', 'All Texture Packs Free', 'Marketplace Content Unlocked', 'Unlimited Items', 'X-Ray Vision', 'Fly Mode in Survival'],
  ARRAY['/screenshots/minecraft/screen1.webp', '/screenshots/minecraft/screen2.webp', '/screenshots/minecraft/screen3.webp', '/screenshots/minecraft/screen4.webp'],
  '[{"label": "v1.21.60.27 (Latest)", "version": "1.21.60.27", "size": "230MB", "downloadUrl": "https://mcpedl.org/uploads_files/02-03-2026/minecraft-26-3-latest.apk", "modType": "Full Mod", "isLatest": true}, {"label": "v1.21.50.07 (Stable)", "version": "1.21.50.07", "size": "225MB", "downloadUrl": "https://mcpedl.org/uploads_files/02-03-2026/minecraft-26-3-stable.apk", "modType": "Full Mod", "isLatest": false}, {"label": "v1.20.80.05 (Root)", "version": "1.20.80.05", "size": "220MB", "downloadUrl": "https://mcpedl.org/uploads_files/02-03-2026/minecraft-26-3-root.apk", "modType": "Root Mod", "isLatest": false}]'::jsonb,
  '2025-08-15T09:00:00Z'::timestamptz,
  '2026-04-10T14:23:23.541Z'::timestamptz
),

-- App 5: YouTube Premium
(
  'youtube-premium-mod',
  'YouTube Premium',
  'apps',
  '/icons/youtube.webp',
  '19.50.36',
  'Ad-Free + Background Play + Download',
  '130MB',
  4.8,
  'Google LLC',
  'Android 7.0+',
  'https://mega.nz/file/example-youtube',
  'Watch YouTube without any ads, play videos in the background, and download content for offline viewing.',
  E'YouTube is the world''s largest video sharing platform with billions of hours of content. This modded version, based on YouTube Vanced''s legacy, unlocks all premium features without a subscription \u2014 completely free.\n\nSay goodbye to pre-roll, mid-roll, and banner ads forever. Background playback lets you listen to music and podcasts with your screen off or while using other apps. You can also download videos in any quality up to 4K for offline viewing, and use picture-in-picture mode on any Android version.\n\nAdditional features include SponsorBlock integration to automatically skip sponsored segments, Return YouTube Dislike to see dislike counts, and a built-in dark AMOLED theme that saves battery. The mod also includes DeArrow for replacing clickbait thumbnails and titles with community-submitted alternatives.',
  ARRAY['No Advertisements (All Types)', 'Background Playback', 'Video Downloads (Up to 4K)', 'Picture-in-Picture Mode', 'SponsorBlock Integration', 'Return YouTube Dislike', 'AMOLED Dark Theme', 'DeArrow (Anti-Clickbait)'],
  ARRAY['/screenshots/youtube/screen1.webp', '/screenshots/youtube/screen2.webp', '/screenshots/youtube/screen3.webp', '/screenshots/youtube/screen4.webp'],
  '[{"label": "v19.50.36 (Latest)", "version": "19.50.36", "size": "130MB", "downloadUrl": "https://mega.nz/file/example-youtube-latest", "modType": "Full Mod", "isLatest": true}, {"label": "v19.45.38 (Stable)", "version": "19.45.38", "size": "125MB", "downloadUrl": "https://mega.nz/file/example-youtube-stable", "modType": "Full Mod", "isLatest": false}, {"label": "v19.40.41 (Lite)", "version": "19.40.41", "size": "85MB", "downloadUrl": "https://mega.nz/file/example-youtube-lite", "modType": "Lite Mod", "isLatest": false}]'::jsonb,
  '2025-10-25T07:00:00Z'::timestamptz,
  '2026-04-08T13:00:00Z'::timestamptz
),

-- App 6: WhatsApp
(
  'whatsapp-mod',
  'WhatsApp',
  'social',
  '/icons/whatsapp.webp',
  '2.25.3.28',
  'Privacy Features + Anti-Delete + Dual Space',
  '58MB',
  4.4,
  'Meta Platforms',
  'Android 5.0+',
  'https://mega.nz/file/example-whatsapp',
  'Take full control of your WhatsApp privacy with anti-delete messages, hidden online status, and dual account support.',
  E'WhatsApp is the most popular messaging app in the world with over 2 billion users. This modded version adds comprehensive privacy controls and quality-of-life features that Meta refuses to include in the official app.\n\nThe anti-delete feature lets you read messages, statuses, and media that the sender deleted \u2014 nothing disappears from your chat. You can hide your online status, blue ticks, typing indicator, and recording status while still being able to see others''. The app also supports running two WhatsApp accounts on the same device without needing a cloner app.\n\nOther enhancements include the ability to send files up to 1GB (vs the 100MB official limit), send full-resolution images without compression, schedule messages, lock individual chats with a PIN or fingerprint, and customize the entire app interface with themes. The mod is built on the latest official WhatsApp release and supports all standard features including end-to-end encryption.',
  ARRAY['Anti-Delete Messages & Statuses', 'Hide Online Status', 'Hide Blue Ticks / Double Ticks', 'Hide Typing & Recording Indicator', 'Dual Account Support', 'Send Files Up to 1GB', 'Full Resolution Image Sharing', 'Message Scheduler'],
  ARRAY['/screenshots/whatsapp/screen1.webp', '/screenshots/whatsapp/screen2.webp', '/screenshots/whatsapp/screen3.webp', '/screenshots/whatsapp/screen4.webp'],
  '[{"label": "v2.25.3.28 (Latest)", "version": "2.25.3.28", "size": "58MB", "downloadUrl": "https://mega.nz/file/example-whatsapp-latest", "modType": "Full Mod", "isLatest": true}, {"label": "v2.24.25.90 (Stable)", "version": "2.24.25.90", "size": "55MB", "downloadUrl": "https://mega.nz/file/example-whatsapp-stable", "modType": "Full Mod", "isLatest": false}, {"label": "v2.24.20.76 (GBWhatsApp)", "version": "2.24.20.76", "size": "62MB", "downloadUrl": "https://mega.nz/file/example-whatsapp-gb", "modType": "GB Mod", "isLatest": false}]'::jsonb,
  '2025-11-30T14:00:00Z'::timestamptz,
  '2026-03-25T10:30:00Z'::timestamptz
),

-- App 7: Subway Surfers
(
  'subway-surfers-mod',
  'Subway Surfers',
  'games',
  '/icons/subway-surfers.webp',
  '3.42.1',
  'Unlimited Coins & Keys + All Characters',
  '175MB',
  4.6,
  'SYBO Games',
  'Android 5.0+',
  'https://mega.nz/file/example-subway-surfers',
  'Dash through the subway with unlimited coins, keys, and every character and hoverboard unlocked from the start.',
  E'Subway Surfers is one of the most downloaded mobile games of all time, featuring colorful HD graphics, smooth gameplay, and an endless running experience set in cities around the world. This modded version removes all grinding and gives you everything from the start.\n\nWith unlimited coins and keys, you can unlock every character, outfit, and hoverboard without playing a single run. All limited-edition and seasonal characters are permanently available, including rare ones that are no longer obtainable in the official game. Keys let you continue your runs indefinitely, making it easy to beat high scores.\n\nThe mod also includes a score multiplier boost, mega headstart on every run, and the ability to use any hoverboard with unlimited duration. All power-ups are maxed out from the beginning. The game runs smoothly on all devices and the mod is updated with every new World Tour location.',
  ARRAY['Unlimited Coins', 'Unlimited Keys', 'All Characters Unlocked', 'All Hoverboards Unlocked', 'All Outfits Unlocked', 'Max Power-Ups', 'Score Multiplier Boost', 'Mega Headstart on Every Run'],
  ARRAY['/screenshots/subway-surfers/screen1.webp', '/screenshots/subway-surfers/screen2.webp', '/screenshots/subway-surfers/screen3.webp', '/screenshots/subway-surfers/screen4.webp'],
  '[{"label": "v3.42.1 (Latest)", "version": "3.42.1", "size": "175MB", "downloadUrl": "https://mega.nz/file/example-subway-surfers-latest", "modType": "Full Mod", "isLatest": true}, {"label": "v3.40.0 (Stable)", "version": "3.40.0", "size": "170MB", "downloadUrl": "https://mega.nz/file/example-subway-surfers-stable", "modType": "Full Mod", "isLatest": false}, {"label": "v3.38.2 (Lite)", "version": "3.38.2", "size": "120MB", "downloadUrl": "https://mega.nz/file/example-subway-surfers-lite", "modType": "Lite Mod", "isLatest": false}]'::jsonb,
  '2025-12-20T11:00:00Z'::timestamptz,
  '2026-04-01T08:45:00Z'::timestamptz
),

-- App 8: Spotify Premium
(
  'spotify-premium-mod',
  'Spotify Premium',
  'apps',
  '/icons/spotify.webp',
  '8.10.9.722',
  'Premium Unlocked + No Ads',
  '65MB',
  4.9,
  'Spotify AB',
  'Android 5.0+',
  'https://mega.nz/file/example-spotify',
  'Stream unlimited music with Spotify Premium features unlocked — no ads, unlimited skips, and offline downloads.',
  E'Spotify is the world''s most popular music streaming service with over 100 million tracks and 5 million podcasts. This modded version unlocks all Premium features completely free \u2014 no subscription required.\n\nEnjoy ad-free listening with unlimited skips, high-quality audio streaming up to 320kbps, and the ability to download songs and playlists for offline playback. You can play any song on demand, use the app on any device, and access Spotify''s entire catalog without restrictions.\n\nThe mod also enables features like lyrics display, Canvas (looping visuals), and crossfade between tracks. Group Session lets you listen with friends in real-time. The mod is regularly updated to match the latest official Spotify release and maintains full compatibility with Spotify Connect for seamless device switching.',
  ARRAY['Premium Unlocked', 'No Advertisements', 'Unlimited Skips', 'Offline Downloads', 'High Quality Audio (320kbps)', 'Play Any Song On Demand', 'Spotify Connect Enabled', 'Lyrics Display'],
  ARRAY['/screenshots/spotify/screen1.webp', '/screenshots/spotify/screen2.webp', '/screenshots/spotify/screen3.webp', '/screenshots/spotify/screen4.webp'],
  '[{"label": "v8.10.9.722 (Latest)", "version": "8.10.9.722", "size": "65MB", "downloadUrl": "https://mega.nz/file/example-spotify-latest", "modType": "Premium Mod", "isLatest": true}, {"label": "v8.9.98.488 (Stable)", "version": "8.9.98.488", "size": "62MB", "downloadUrl": "https://mega.nz/file/example-spotify-stable", "modType": "Premium Mod", "isLatest": false}, {"label": "v8.8.74.652 (Lite)", "version": "8.8.74.652", "size": "45MB", "downloadUrl": "https://mega.nz/file/example-spotify-lite", "modType": "Lite Mod", "isLatest": false}]'::jsonb,
  '2026-01-05T12:00:00Z'::timestamptz,
  '2026-04-10T09:00:00Z'::timestamptz
);

-- ============================================================
-- Analytics Tables
-- ============================================================

-- Page Views tracking
CREATE TABLE IF NOT EXISTS page_views (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  page_path TEXT NOT NULL,
  app_slug TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE page_views ENABLE ROW LEVEL SECURITY;

-- Allow anyone to insert page views (for client-side tracking)
CREATE POLICY "Allow public insert page_views"
  ON page_views
  FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);

-- Only authenticated users can read page views
CREATE POLICY "Allow authenticated read page_views"
  ON page_views
  FOR SELECT
  TO authenticated
  USING (true);

-- Download Events tracking
CREATE TABLE IF NOT EXISTS download_events (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  app_slug TEXT NOT NULL,
  version_label TEXT DEFAULT '',
  created_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE download_events ENABLE ROW LEVEL SECURITY;

-- Allow anyone to insert download events
CREATE POLICY "Allow public insert download_events"
  ON download_events
  FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);

-- Only authenticated users can read download events
CREATE POLICY "Allow authenticated read download_events"
  ON download_events
  FOR SELECT
  TO authenticated
  USING (true);

-- Index for faster queries
CREATE INDEX IF NOT EXISTS idx_page_views_created_at ON page_views(created_at);
CREATE INDEX IF NOT EXISTS idx_page_views_app_slug ON page_views(app_slug);
CREATE INDEX IF NOT EXISTS idx_download_events_created_at ON download_events(created_at);
CREATE INDEX IF NOT EXISTS idx_download_events_app_slug ON download_events(app_slug);
