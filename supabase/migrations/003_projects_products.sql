-- 003_projects_products.sql
-- Projects and Products tables for gallery pages

-- Projects table
CREATE TABLE IF NOT EXISTS projects (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title VARCHAR(255) NOT NULL,
  description TEXT,
  images TEXT[],
  industry VARCHAR(100),
  year INTEGER,
  client_name VARCHAR(255),
  project_type VARCHAR(100),
  location VARCHAR(255),
  project_value VARCHAR(100),
  duration VARCHAR(100),
  is_featured BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Products table
CREATE TABLE IF NOT EXISTS products (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  description TEXT,
  specs JSONB DEFAULT '{}',
  images TEXT[],
  category VARCHAR(100),
  subcategory VARCHAR(100),
  price_range VARCHAR(100),
  brochure_url TEXT,
  video_url TEXT,
  is_active BOOLEAN DEFAULT TRUE,
  is_featured BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes for projects
CREATE INDEX idx_projects_industry ON projects(industry);
CREATE INDEX idx_projects_year ON projects(year);
CREATE INDEX idx_projects_project_type ON projects(project_type);
CREATE INDEX idx_projects_is_featured ON projects(is_featured);

-- Create indexes for products
CREATE INDEX idx_products_category ON products(category);
CREATE INDEX idx_products_subcategory ON products(subcategory);
CREATE INDEX idx_products_is_active ON products(is_active);
CREATE INDEX idx_products_is_featured ON products(is_featured);

-- Enable Row Level Security
ALTER TABLE projects ENABLE ROW LEVEL SECURITY;
ALTER TABLE products ENABLE ROW LEVEL SECURITY;

-- Create policies for projects
CREATE POLICY "Projects are viewable by everyone" ON projects
  FOR SELECT USING (true);

CREATE POLICY "Projects are editable by admins" ON projects
  FOR ALL USING (auth.jwt() ->> 'role' = 'admin');

-- Create policies for products
CREATE POLICY "Products are viewable by everyone" ON products
  FOR SELECT USING (true);

CREATE POLICY "Products are editable by admins" ON products
  FOR ALL USING (auth.jwt() ->> 'role' = 'admin');

-- Create updated_at triggers
CREATE TRIGGER update_projects_updated_at
  BEFORE UPDATE ON projects
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_products_updated_at
  BEFORE UPDATE ON products
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();
