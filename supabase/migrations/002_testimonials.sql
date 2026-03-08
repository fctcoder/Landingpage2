-- 002_testimonials.sql
-- Testimonials table for client testimonials

CREATE TABLE IF NOT EXISTS testimonials (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  position VARCHAR(255),
  company VARCHAR(255),
  quote TEXT NOT NULL,
  rating INTEGER CHECK (rating >= 1 AND rating <= 5),
  industry VARCHAR(100),
  avatar_url TEXT,
  is_featured BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes
CREATE INDEX idx_testimonials_industry ON testimonials(industry);
CREATE INDEX idx_testimonials_is_featured ON testimonials(is_featured);
CREATE INDEX idx_testimonials_rating ON testimonials(rating);

-- Enable Row Level Security
ALTER TABLE testimonials ENABLE ROW LEVEL SECURITY;

-- Create policy for public read access
CREATE POLICY "Testimonials are viewable by everyone" ON testimonials
  FOR SELECT USING (true);

-- Create policy for admin write access
CREATE POLICY "Testimonials are editable by admins" ON testimonials
  FOR ALL USING (auth.jwt() ->> 'role' = 'admin');

-- Create updated_at trigger
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_testimonials_updated_at
  BEFORE UPDATE ON testimonials
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();
