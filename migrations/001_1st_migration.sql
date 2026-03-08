-- =============================================================================
-- Migration: 001_1st_migration.sql
-- Description: Create contact_submissions table for the Contact Us form
-- Created: 2026-03-08
-- =============================================================================

-- ---------------------------------------------------------------------------
-- Helper: updated_at trigger function
-- (Creates it only if it doesn't already exist)
-- ---------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------
-- Table: contact_submissions
-- Stores every submission from the Contact Us form on the website.
--
-- Form fields captured:
--   name                 → Full Name        (required)
--   email                → Email Address    (required)
--   phone                → Phone Number     (optional)
--   company              → Company Name     (optional)
--   industry             → Industry         (optional dropdown)
--   country              → Country          (optional)
--   subject              → Subject          (optional)
--   message              → Message          (required)
--   subscribe_newsletter → Newsletter opt-in checkbox
--
-- Internal / admin fields:
--   status               → Workflow status  (new → in_progress → resolved)
--   priority             → Priority level   (low / normal / high)
--   source               → Origin of submission (default: 'contact_form')
--   assigned_to          → Admin user UUID who is handling the submission
--   notes                → Internal admin notes / follow-up comments
--   responded_at         → Timestamp when a reply was sent
--   ip_address           → Client IP for spam/security auditing
--   user_agent           → Browser UA string for debugging
--   created_at           → Auto-set on INSERT
--   updated_at           → Auto-updated via trigger on every UPDATE
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS contact_submissions (
  -- Primary key
  id                   UUID          PRIMARY KEY DEFAULT gen_random_uuid(),

  -- ── Contact form fields ────────────────────────────────────────────────
  name                 VARCHAR(255)  NOT NULL,
  email                VARCHAR(255)  NOT NULL,
  phone                VARCHAR(50),
  company              VARCHAR(255),

  -- Allowed values mirror the <select> options in the form:
  -- 'medical' | 'pharmaceutical' | 'gloves' | 'fmcg' | 'other'
  industry             VARCHAR(100)
    CHECK (industry IN ('medical', 'pharmaceutical', 'gloves', 'fmcg', 'other')),

  country              VARCHAR(100),
  subject              VARCHAR(255),
  message              TEXT          NOT NULL,
  subscribe_newsletter BOOLEAN       NOT NULL DEFAULT FALSE,

  -- ── Internal / admin fields ────────────────────────────────────────────
  -- Workflow status: starts as 'new', moves through in_progress → resolved
  -- Mark as 'spam' to suppress from normal views without deleting.
  status               VARCHAR(50)   NOT NULL DEFAULT 'new'
    CHECK (status IN ('new', 'in_progress', 'resolved', 'spam')),

  -- Priority flag for admin triage
  priority             VARCHAR(20)   NOT NULL DEFAULT 'normal'
    CHECK (priority IN ('low', 'normal', 'high')),

  -- Where this submission came from (useful if you add multiple forms later)
  source               VARCHAR(100)  NOT NULL DEFAULT 'contact_form',

  -- The admin (auth.users) currently handling this submission
  assigned_to          UUID          REFERENCES auth.users(id) ON DELETE SET NULL,

  -- Internal admin notes / CRM-style follow-up text
  notes                TEXT,

  -- Timestamp of when a reply was actually sent to the submitter
  responded_at         TIMESTAMPTZ,

  -- For spam detection / security auditing (populated server-side)
  ip_address           VARCHAR(45),   -- supports IPv4 and IPv6
  user_agent           TEXT,

  -- ── Timestamps ────────────────────────────────────────────────────────
  created_at           TIMESTAMPTZ   NOT NULL DEFAULT NOW(),
  updated_at           TIMESTAMPTZ   NOT NULL DEFAULT NOW()
);

-- ---------------------------------------------------------------------------
-- Indexes – speed up the most common admin queries
-- ---------------------------------------------------------------------------

-- Filter / sort by workflow status (most frequent admin view)
CREATE INDEX IF NOT EXISTS idx_contact_status
  ON contact_submissions(status);

-- Look up submissions by email (e.g. "has this person written before?")
CREATE INDEX IF NOT EXISTS idx_contact_email
  ON contact_submissions(email);

-- Filter by industry segment
CREATE INDEX IF NOT EXISTS idx_contact_industry
  ON contact_submissions(industry);

-- Sort dashboard by newest first
CREATE INDEX IF NOT EXISTS idx_contact_created_at
  ON contact_submissions(created_at DESC);

-- Filter by admin assignee
CREATE INDEX IF NOT EXISTS idx_contact_assigned_to
  ON contact_submissions(assigned_to);

-- ---------------------------------------------------------------------------
-- Row Level Security (RLS)
-- ---------------------------------------------------------------------------
ALTER TABLE contact_submissions ENABLE ROW LEVEL SECURITY;

-- Anyone (including anonymous visitors) can INSERT a new submission.
-- Explicitly granted to `anon` (unauthenticated) and `authenticated` roles.
-- Required when the Supabase anon key is used from the client or server.
CREATE POLICY "Public can insert contact submissions"
  ON contact_submissions
  FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);


-- Only authenticated admins can SELECT, UPDATE, or DELETE submissions.
-- Admins must have the custom JWT claim: role = 'admin'
-- Set this in your Supabase Auth → Hooks or via a custom JWT template.
CREATE POLICY "Admins can manage all contact submissions"
  ON contact_submissions
  FOR ALL
  USING (auth.jwt() ->> 'role' = 'admin');

-- ---------------------------------------------------------------------------
-- Trigger: keep updated_at current on every UPDATE
-- ---------------------------------------------------------------------------
CREATE TRIGGER trg_contact_submissions_updated_at
  BEFORE UPDATE ON contact_submissions
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- ---------------------------------------------------------------------------
-- View: contact_submissions_overview
-- Handy admin dashboard view – shows unresolved submissions by default.
-- ---------------------------------------------------------------------------
CREATE OR REPLACE VIEW contact_submissions_overview AS
SELECT
  id,
  name,
  email,
  phone,
  company,
  industry,
  country,
  subject,
  LEFT(message, 120) || CASE WHEN LENGTH(message) > 120 THEN '…' ELSE '' END AS message_preview,
  subscribe_newsletter,
  status,
  priority,
  source,
  assigned_to,
  responded_at,
  created_at,
  updated_at
FROM contact_submissions
WHERE status != 'spam'
ORDER BY
  CASE priority WHEN 'high' THEN 1 WHEN 'normal' THEN 2 ELSE 3 END,
  created_at DESC;

-- ---------------------------------------------------------------------------
-- Function: get_contact_stats()
-- Returns a summary row useful for an admin dashboard widget.
-- ---------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION get_contact_stats()
RETURNS TABLE (
  total_submissions   BIGINT,
  new_submissions     BIGINT,
  in_progress         BIGINT,
  resolved            BIGINT,
  spam                BIGINT,
  this_month          BIGINT,
  newsletter_opt_ins  BIGINT
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    COUNT(*)                                                              AS total_submissions,
    COUNT(*) FILTER (WHERE status = 'new')                               AS new_submissions,
    COUNT(*) FILTER (WHERE status = 'in_progress')                       AS in_progress,
    COUNT(*) FILTER (WHERE status = 'resolved')                          AS resolved,
    COUNT(*) FILTER (WHERE status = 'spam')                              AS spam,
    COUNT(*) FILTER (WHERE created_at >= date_trunc('month', NOW()))     AS this_month,
    COUNT(*) FILTER (WHERE subscribe_newsletter = TRUE)                  AS newsletter_opt_ins
  FROM contact_submissions;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- =============================================================================
-- End of migration 001_1st_migration.sql
-- =============================================================================
