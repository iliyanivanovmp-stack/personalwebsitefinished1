/*
  # Fix RLS policy for contact form submissions

  1. Security Changes
    - Update the INSERT policy to properly allow anonymous users to submit contact forms
    - The previous policy had incorrect syntax that was blocking submissions
    - New policy explicitly allows INSERT operations for the 'anon' role

  2. Policy Details
    - Policy name: "Allow anonymous users to submit contact forms"
    - Operation: INSERT
    - Role: anon (anonymous users)
    - Check: true (allows all inserts from anonymous users)
*/

-- Drop the existing restrictive policy
DROP POLICY IF EXISTS "Anyone can insert contact submissions" ON contact_submissions;

-- Create a new policy that properly allows anonymous users to insert contact forms
CREATE POLICY "Allow anonymous users to submit contact forms"
  ON contact_submissions
  FOR INSERT
  TO anon
  WITH CHECK (true);