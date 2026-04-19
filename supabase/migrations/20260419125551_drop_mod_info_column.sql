-- Migration: drop_mod_info_column
-- Description: Remove mod_info column as it's replaced by mod_features array
-- Created: 2026-04-19

-- Drop the mod_info column from apps table
ALTER TABLE apps DROP COLUMN IF EXISTS mod_info;
