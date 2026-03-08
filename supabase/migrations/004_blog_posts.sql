-- 004_blog_posts.sql
-- Blog posts table for newsletter/blog section

CREATE TABLE IF NOT EXISTS blog_posts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title VARCHAR(255) NOT NULL,
  slug VARCHAR(255) UNIQUE NOT NULL,
  content TEXT,
  excerpt TEXT,
  cover_image TEXT,
  category VARCHAR(100),
  tags TEXT[],
  author_id UUID REFERENCES auth.users(id),
  author_name VARCHAR(255),
  reading_time INTEGER DEFAULT 5,
  published_at TIMESTAMPTZ,
  is_published BOOLEAN DEFAULT FALSE,
  is_featured BOOLEAN DEFAULT FALSE,
  meta_title VARCHAR(255),
  meta_description TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes
CREATE INDEX idx_blog_posts_slug ON blog_posts(slug);
CREATE INDEX idx_blog_posts_category ON blog_posts(category);
CREATE INDEX idx_blog_posts_is_published ON blog_posts(is_published);
CREATE INDEX idx_blog_posts_published_at ON blog_posts(published_at DESC);
CREATE INDEX idx_blog_posts_author_id ON blog_posts(author_id);

-- Create GIN index for tags array
CREATE INDEX idx_blog_posts_tags ON blog_posts USING GIN(tags);

-- Enable Row Level Security
ALTER TABLE blog_posts ENABLE ROW LEVEL Security;

-- Create policies
CREATE POLICY "Published posts are viewable by everyone" ON blog_posts
  FOR SELECT USING (is_published = true);

CREATE POLICY "Unpublished posts are viewable by admins" ON blog_posts
  FOR SELECT USING (auth.jwt() ->> 'role' = 'admin');

CREATE POLICY "Blog posts are editable by admins" ON blog_posts
  FOR ALL USING (auth.jwt() ->> 'role' = 'admin');

-- Create updated_at trigger
CREATE TRIGGER update_blog_posts_updated_at
  BEFORE UPDATE ON blog_posts
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Function to generate slug from title
CREATE OR REPLACE FUNCTION generate_slug(title TEXT)
RETURNS VARCHAR(255) AS $$
DECLARE
  base_slug VARCHAR(255);
  final_slug VARCHAR(255);
  counter INTEGER := 0;
BEGIN
  base_slug := lower(regexp_replace(title, '[^a-zA-Z0-9]+', '-', 'g'));
  base_slug := regexp_replace(base_slug, '^-|-$', '', 'g');
  
  final_slug := base_slug;
  
  WHILE EXISTS (SELECT 1 FROM blog_posts WHERE slug = final_slug) LOOP
    counter := counter + 1;
    final_slug := base_slug || '-' || counter;
  END LOOP;
  
  RETURN final_slug;
END;
$$ LANGUAGE plpgsql;
