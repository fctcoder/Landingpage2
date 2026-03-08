-- 005_newsletter_subscribers.sql
-- Newsletter subscribers table

CREATE TABLE IF NOT EXISTS newsletter_subscribers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email VARCHAR(255) UNIQUE NOT NULL,
  name VARCHAR(255),
  source VARCHAR(100) DEFAULT 'website',
  subscribed_at TIMESTAMPTZ DEFAULT NOW(),
  is_active BOOLEAN DEFAULT TRUE,
  unsubscribed_at TIMESTAMPTZ,
  preferences JSONB DEFAULT '{}',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes
CREATE UNIQUE INDEX idx_newsletter_subscribers_email ON newsletter_subscribers(email);
CREATE INDEX idx_newsletter_subscribers_is_active ON newsletter_subscribers(is_active);

-- Enable Row Level Security
ALTER TABLE newsletter_subscribers ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Newsletter subscription is public" ON newsletter_subscribers
  FOR INSERT WITH CHECK (true);

CREATE POLICY "Newsletter subscribers can view own data" ON newsletter_subscribers
  FOR SELECT USING (email = auth.jwt() ->> 'email');

CREATE POLICY "Newsletter is manageable by admins" ON newsletter_subscribers
  FOR ALL USING (auth.jwt() ->> 'role' = 'admin');

-- Create updated_at trigger
CREATE TRIGGER update_newsletter_subscribers_updated_at
  BEFORE UPDATE ON newsletter_subscribers
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Function to unsubscribe
CREATE OR REPLACE FUNCTION unsubscribe_newsletter(subscriber_email VARCHAR(255))
RETURNS VOID AS $$
BEGIN
  UPDATE newsletter_subscribers
  SET is_active = FALSE, unsubscribed_at = NOW()
  WHERE email = subscriber_email;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
