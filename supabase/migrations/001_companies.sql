-- 001_companies.sql
-- Companies table for partner/client companies

CREATE TABLE IF NOT EXISTS companies (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  logo_url TEXT,
  industry VARCHAR(100),
  website VARCHAR(255),
  description TEXT,
  is_partner BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index for faster queries
CREATE INDEX idx_companies_industry ON companies(industry);
CREATE INDEX idx_companies_is_partner ON companies(is_partner);

-- Enable Row Level Security
ALTER TABLE companies ENABLE ROW LEVEL SECURITY;

-- Create policy for public read access
CREATE POLICY "Companies are viewable by everyone" ON companies
  FOR SELECT USING (true);

-- Create policy for admin write access
CREATE POLICY "Companies are editable by admins" ON companies
  FOR ALL USING (auth.jwt() ->> 'role' = 'admin');
