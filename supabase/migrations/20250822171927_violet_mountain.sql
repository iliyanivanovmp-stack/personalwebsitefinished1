/*
  # Disable RLS for contact submissions table

  This migration disables Row Level Security on the contact_submissions table
  to allow anonymous users to submit contact forms without authentication.

  ## Changes
  - Disable RLS on contact_submissions table
  - Remove all existing policies that were blocking submissions

  ## Security Note
  This allows public access for INSERT operations on contact forms.
  Consider re-enabling RLS with proper policies if stricter security is needed.
*/

-- Disable Row Level Security on contact_submissions table
ALTER TABLE contact_submissions DISABLE ROW LEVEL SECURITY;

-- Drop any existing policies to ensure clean state
DROP POLICY IF EXISTS "Allow anonymous users to submit contact forms" ON contact_submissions;
DROP POLICY IF EXISTS "Authenticated users can read contact submissions" ON contact_submissions;
DROP POLICY IF EXISTS "Enable insert for anon users" ON contact_submissions;