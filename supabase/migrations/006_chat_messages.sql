-- 006_chat_messages.sql
-- Chat sessions and messages tables for real-time chat

-- Chat sessions table
CREATE TABLE IF NOT EXISTS chat_sessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  visitor_id VARCHAR(255),
  visitor_name VARCHAR(255),
  visitor_email VARCHAR(255),
  visitor_phone VARCHAR(50),
  visitor_ip VARCHAR(45),
  visitor_user_agent TEXT,
  status VARCHAR(50) DEFAULT 'active' CHECK (status IN ('active', 'waiting', 'ended', 'missed')),
  priority VARCHAR(20) DEFAULT 'normal' CHECK (priority IN ('low', 'normal', 'high')),
  assigned_to UUID REFERENCES auth.users(id),
  first_message_at TIMESTAMPTZ,
  last_message_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Chat messages table
CREATE TABLE IF NOT EXISTS chat_messages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id UUID REFERENCES chat_sessions(id) ON DELETE CASCADE,
  message TEXT NOT NULL,
  sender_type VARCHAR(20) CHECK (sender_type IN ('visitor', 'admin', 'bot')),
  sender_id UUID REFERENCES auth.users(id),
  sender_name VARCHAR(255),
  is_read BOOLEAN DEFAULT FALSE,
  read_at TIMESTAMPTZ,
  attachments JSONB DEFAULT '[]',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes for chat_sessions
CREATE INDEX idx_chat_sessions_status ON chat_sessions(status);
CREATE INDEX idx_chat_sessions_visitor_id ON chat_sessions(visitor_id);
CREATE INDEX idx_chat_sessions_assigned_to ON chat_sessions(assigned_to);
CREATE INDEX idx_chat_sessions_created_at ON chat_sessions(created_at DESC);

-- Create indexes for chat_messages
CREATE INDEX idx_chat_messages_session_id ON chat_messages(session_id);
CREATE INDEX idx_chat_messages_created_at ON chat_messages(created_at DESC);
CREATE INDEX idx_chat_messages_is_read ON chat_messages(is_read);

-- Enable Row Level Security
ALTER TABLE chat_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE chat_messages ENABLE ROW LEVEL SECURITY;

-- Create policies for chat_sessions
CREATE POLICY "Chat sessions viewable by owner or admin" ON chat_sessions
  FOR SELECT USING (
    visitor_id = auth.jwt() ->> 'sub' OR 
    auth.jwt() ->> 'role' = 'admin'
  );

CREATE POLICY "Chat sessions insertable by anyone" ON chat_sessions
  FOR INSERT WITH CHECK (true);

CREATE POLICY "Chat sessions updatable by admin" ON chat_sessions
  FOR UPDATE USING (auth.jwt() ->> 'role' = 'admin');

-- Create policies for chat_messages
CREATE POLICY "Chat messages viewable by session owner or admin" ON chat_messages
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM chat_sessions 
      WHERE chat_sessions.id = chat_messages.session_id 
      AND (chat_sessions.visitor_id = auth.jwt() ->> 'sub' OR auth.jwt() ->> 'role' = 'admin')
    )
  );

CREATE POLICY "Chat messages insertable by session owner or admin" ON chat_messages
  FOR INSERT WITH CHECK (true);

CREATE POLICY "Chat messages updatable by admin" ON chat_messages
  FOR UPDATE USING (auth.jwt() ->> 'role' = 'admin');

-- Create updated_at triggers
CREATE TRIGGER update_chat_sessions_updated_at
  BEFORE UPDATE ON chat_sessions
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Function to create session with visitor info
CREATE OR REPLACE FUNCTION create_chat_session(
  v_name VARCHAR(255),
  v_email VARCHAR(255),
  v_phone VARCHAR(50),
  v_visitor_id VARCHAR(255)
)
RETURNS UUID AS $$
DECLARE
  new_session_id UUID;
BEGIN
  INSERT INTO chat_sessions (
    visitor_name, 
    visitor_email, 
    visitor_phone, 
    visitor_id,
    status
  ) VALUES (
    v_name, 
    v_email, 
    v_phone, 
    v_visitor_id,
    'waiting'
  ) RETURNING id INTO new_session_id;
  
  RETURN new_session_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to mark messages as read
CREATE OR REPLACE FUNCTION mark_messages_read(p_session_id UUID)
RETURNS VOID AS $$
BEGIN
  UPDATE chat_messages
  SET is_read = TRUE, read_at = NOW()
  WHERE session_id = p_session_id AND is_read = FALSE;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Enable realtime for chat_messages
ALTER PUBLICATION supabase_realtime ADD TABLE chat_messages;
