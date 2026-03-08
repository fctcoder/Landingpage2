export default defineEventHandler(async (event) => {
  const method = getMethod(event)
  const query = getQuery(event)
  const body = await readBody()
  
  try {
    const config = useRuntimeConfig()
    const supabaseUrl = config.public.supabaseUrl
    const supabaseKey = config.public.supabaseKey
    
    if (method === 'POST') {
      if (body.action === 'create_session') {
        const session = await $fetch(`${supabaseUrl}/rest/v1/chat_sessions`, {
          method: 'POST',
          headers: {
            'apikey': supabaseKey,
            'Content-Type': 'application/json',
            'Prefer': 'return=representation'
          },
          body: {
            visitor_name: body.visitor_name,
            visitor_email: body.visitor_email,
            visitor_phone: body.visitor_phone,
            status: 'waiting'
          }
        })
        
        return { success: true, data: session }
      }
      
      if (body.action === 'send_message') {
        const message = await $fetch(`${supabaseUrl}/rest/v1/chat_messages`, {
          method: 'POST',
          headers: {
            'apikey': supabaseKey,
            'Content-Type': 'application/json',
            'Prefer': 'return=representation'
          },
          body: {
            session_id: body.session_id,
            message: body.message,
            sender_type: 'visitor'
          }
        })
        
        return { success: true, data: message }
      }
    }
    
    if (method === 'GET' && query.session_id) {
      const messages = await $fetch(`${supabaseUrl}/rest/v1/chat_messages?session_id=eq.${query.session_id}&order=created_at.asc`, {
        method: 'GET',
        headers: {
          'apikey': supabaseKey,
          'Content-Type': 'application/json'
        }
      })
      
      return { success: true, data: messages }
    }
    
    return { success: false, error: 'Invalid action' }
  } catch (error) {
    console.error('Chat API error:', error)
    return { success: false, error: 'Failed to process request' }
  }
})
