import type { ChatMessage, ChatSession } from '~/types'

export const useChat = () => {
  const supabase = useSupabaseClient()
  const session = ref<ChatSession | null>(null)
  const messages = ref<ChatMessage[]>([])
  const isLoading = ref(false)
  const isOpen = ref(false)
  const isTyping = ref(false)
  let subscription: ReturnType<typeof supabase.channel> | null = null

  const createSession = async (visitorInfo?: { name?: string; email?: string; phone?: string }) => {
    isLoading.value = true
    try {
      const { data, error } = await supabase
        .from('chat_sessions')
        .insert({
          visitor_name: visitorInfo?.name,
          visitor_email: visitorInfo?.email,
          visitor_phone: visitorInfo?.phone,
          status: 'active'
        })
        .select()
        .single()
      
      if (error) throw error
      session.value = data
      
      // Subscribe to real-time messages
      subscribeToMessages(data.id)
      
      return data
    } catch (error) {
      console.error('Error creating chat session:', error)
      throw error
    } finally {
      isLoading.value = false
    }
  }

  const getSession = async (sessionId: string) => {
    try {
      const { data, error } = await supabase
        .from('chat_sessions')
        .select('*')
        .eq('id', sessionId)
        .single()
      
      if (error) throw error
      session.value = data
      
      // Load existing messages
      await loadMessages(sessionId)
      
      // Subscribe to real-time messages
      subscribeToMessages(sessionId)
      
      return data
    } catch (error) {
      console.error('Error getting session:', error)
      throw error
    }
  }

  const loadMessages = async (sessionId: string) => {
    try {
      const { data, error } = await supabase
        .from('chat_messages')
        .select('*')
        .eq('session_id', sessionId)
        .order('created_at', { ascending: true })
      
      if (error) throw error
      messages.value = data
      return data
    } catch (error) {
      console.error('Error loading messages:', error)
      throw error
    }
  }

  const subscribeToMessages = (sessionId: string) => {
    if (subscription) {
      subscription.unsubscribe()
    }

    subscription = supabase
      .channel(`chat:${sessionId}`)
      .on(
        'postgres_changes',
        {
          event: 'INSERT',
          schema: 'public',
          table: 'chat_messages',
          filter: `session_id=eq.${sessionId}`
        },
        (payload) => {
          const newMessage = payload.new as ChatMessage
          messages.value.push(newMessage)
          
          if (newMessage.sender_type === 'admin') {
            isTyping.value = false
          }
        }
      )
      .subscribe()
  }

  const sendMessage = async (message: string) => {
    if (!session.value) return
    
    isLoading.value = true
    try {
      const { data, error } = await supabase
        .from('chat_messages')
        .insert({
          session_id: session.value.id,
          message,
          sender_type: 'visitor'
        })
        .select()
        .single()
      
      if (error) throw error
      
      // Update session updated_at
      await supabase
        .from('chat_sessions')
        .update({ updated_at: new Date().toISOString() })
        .eq('id', session.value.id)
      
      return data
    } catch (error) {
      console.error('Error sending message:', error)
      throw error
    } finally {
      isLoading.value = false
    }
  }

  const closeChat = () => {
    isOpen.value = false
    if (subscription) {
      subscription.unsubscribe()
      subscription = null
    }
  }

  const openChat = () => {
    isOpen.value = true
  }

  const endSession = async () => {
    if (!session.value) return
    
    try {
      await supabase
        .from('chat_sessions')
        .update({ status: 'ended', updated_at: new Date().toISOString() })
        .eq('id', session.value.id)
      
      closeChat()
      session.value = null
      messages.value = []
    } catch (error) {
      console.error('Error ending session:', error)
    }
  }

  const restoreSession = async () => {
    if (process.client) {
      const savedSessionId = localStorage.getItem('chat_session_id')
      if (savedSessionId) {
        try {
          await getSession(savedSessionId)
        } catch {
          localStorage.removeItem('chat_session_id')
        }
      }
    }
  }

  const saveSession = () => {
    if (process.client && session.value) {
      localStorage.setItem('chat_session_id', session.value.id)
    }
  }

  onMounted(() => {
    restoreSession()
  })

  onUnmounted(() => {
    if (subscription) {
      subscription.unsubscribe()
    }
  })

  return {
    session,
    messages,
    isLoading,
    isOpen,
    isTyping,
    createSession,
    getSession,
    loadMessages,
    sendMessage,
    closeChat,
    openChat,
    endSession,
    saveSession
  }
}
