-- 008_contact_submissions.sql
-- Contact form submissions table

CREATE TABLE IF NOT EXISTS contact_submissions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  phone VARCHAR(50),
  company VARCHAR(255),
  industry VARCHAR(100),
  country VARCHAR(100),
  subject VARCHAR(255),
  message TEXT NOT NULL,
  status VARCHAR(50) DEFAULT 'new' CHECK (status IN ('new', 'in_progress', 'resolved', 'spam')),
  priority VARCHAR(20) DEFAULT 'normal' CHECK (priority IN ('low', 'normal', 'high')),
  source VARCHAR(100) DEFAULT 'contact_form',
  assigned_to UUID REFERENCES auth.users(id),
  notes TEXT,
  responded_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Quote requests table (for specific product inquiries)
CREATE TABLE IF NOT EXISTS quote_requests (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  phone VARCHAR(50),
  company VARCHAR(255),
  industry VARCHAR(100),
  country VARCHAR(100),
  product_id UUID REFERENCES products(id),
  product_name VARCHAR(255),
  quantity VARCHAR(100),
  requirements TEXT,
  budget VARCHAR(100),
  timeline VARCHAR(100),
  status VARCHAR(50) DEFAULT 'new' CHECK (status IN ('new', 'quoted', 'accepted', 'rejected', 'expired')),
  assigned_to UUID REFERENCES auth.users(id),
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes
CREATE INDEX idx_contact_submissions_status ON contact_submissions(status);
CREATE INDEX idx_contact_submissions_email ON contact_submissions(email);
CREATE INDEX idx_contact_submissions_industry ON contact_submissions(industry);
CREATE INDEX idx_contact_submissions_created_at ON contact_submissions(created_at DESC);
CREATE INDEX idx_quote_requests_status ON quote_requests(status);
CREATE INDEX idx_quote_requests_product_id ON quote_requests(product_id);
CREATE INDEX idx_quote_requests_created_at ON quote_requests(created_at DESC);

-- Enable Row Level Security
ALTER TABLE contact_submissions ENABLE ROW LEVEL SECURITY;
ALTER TABLE quote_requests ENABLE ROW LEVEL SECURITY;

-- Create policies for contact_submissions
CREATE POLICY "Contact submissions are insertable by everyone" ON contact_submissions
  FOR INSERT WITH CHECK (true);

CREATE POLICY "Contact submissions are manageable by admins" ON contact_submissions
  FOR ALL USING (auth.jwt() ->> 'role' = 'admin');

-- Create policies for quote_requests
CREATE POLICY "Quote requests are insertable by everyone" ON quote_requests
  FOR INSERT WITH CHECK (true);

CREATE POLICY "Quote requests are manageable by admins" ON quote_requests
  FOR ALL USING (auth.jwt() ->> 'role' = 'admin');

-- Create updated_at triggers
CREATE TRIGGER update_contact_submissions_updated_at
  BEFORE UPDATE ON contact_submissions
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_quote_requests_updated_at
  BEFORE UPDATE ON quote_requests
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Function to get submission statistics
CREATE OR REPLACE FUNCTION get_submission_stats()
RETURNS TABLE (
  total_submissions BIGINT,
  new_submissions BIGINT,
  in_progress BIGINT,
  resolved BIGINT,
  this_month BIGINT
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    COUNT(*) as total_submissions,
    COUNT(*) FILTER (WHERE status = 'new') as new_submissions,
    COUNT(*) FILTER (WHERE status = 'in_progress') as in_progress,
    COUNT(*) FILTER (WHERE status = 'resolved') as resolved,
    COUNT(*) FILTER (WHERE created_at >= date_trunc('month', NOW())) as this_month
  FROM contact_submissions;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
