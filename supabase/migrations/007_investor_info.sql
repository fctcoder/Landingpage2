-- 007_investor_info.sql
-- Investor information table

CREATE TABLE IF NOT EXISTS investor_info (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title VARCHAR(255) NOT NULL,
  description TEXT,
  content TEXT,
  document_url TEXT,
  document_size VARCHAR(50),
  type VARCHAR(50) CHECK (type IN ('report', 'presentation', 'financial', 'governance', 'news')),
  year INTEGER,
  quarter VARCHAR(10),
  month VARCHAR(20),
  is_featured BOOLEAN DEFAULT FALSE,
  is_published BOOLEAN DEFAULT TRUE,
  download_count INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Financial highlights table
CREATE TABLE IF NOT EXISTS financial_highlights (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  period VARCHAR(100) NOT NULL,
  year INTEGER NOT NULL,
  quarter INTEGER,
  revenue DECIMAL(15,2),
  profit DECIMAL(15,2),
  growth_percentage DECIMAL(5,2),
  employees INTEGER,
  projects_completed INTEGER,
  countries_served INTEGER,
  metrics JSONB DEFAULT '{}',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Board members table
CREATE TABLE IF NOT EXISTS board_members (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  position VARCHAR(255) NOT NULL,
  bio TEXT,
  image_url TEXT,
  linkedin_url VARCHAR(255),
  order_index INTEGER DEFAULT 0,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes
CREATE INDEX idx_investor_info_type ON investor_info(type);
CREATE INDEX idx_investor_info_year ON investor_info(year);
CREATE INDEX idx_investor_info_is_published ON investor_info(is_published);
CREATE INDEX idx_financial_highlights_year ON financial_highlights(year);
CREATE INDEX idx_board_members_order ON board_members(order_index);

-- Enable Row Level Security
ALTER TABLE investor_info ENABLE ROW LEVEL SECURITY;
ALTER TABLE financial_highlights ENABLE ROW LEVEL SECURITY;
ALTER TABLE board_members ENABLE ROW LEVEL SECURITY;

-- Create policies for investor_info
CREATE POLICY "Published investor info is viewable by everyone" ON investor_info
  FOR SELECT USING (is_published = true);

CREATE POLICY "Investor info is manageable by admins" ON investor_info
  FOR ALL USING (auth.jwt() ->> 'role' = 'admin');

-- Create policies for financial_highlights
CREATE POLICY "Financial highlights are viewable by everyone" ON financial_highlights
  FOR SELECT USING (true);

CREATE POLICY "Financial highlights are manageable by admins" ON financial_highlights
  FOR ALL USING (auth.jwt() ->> 'role' = 'admin');

-- Create policies for board_members
CREATE POLICY "Active board members are viewable by everyone" ON board_members
  FOR SELECT USING (is_active = true);

CREATE POLICY "Board members are manageable by admins" ON board_members
  FOR ALL USING (auth.jwt() ->> 'role' = 'admin');

-- Create updated_at triggers
CREATE TRIGGER update_investor_info_updated_at
  BEFORE UPDATE ON investor_info
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_financial_highlights_updated_at
  BEFORE UPDATE ON financial_highlights
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_board_members_updated_at
  BEFORE UPDATE ON board_members
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Function to increment download count
CREATE OR REPLACE FUNCTION increment_download_count(p_id UUID)
RETURNS VOID AS $$
BEGIN
  UPDATE investor_info
  SET download_count = download_count + 1
  WHERE id = p_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
