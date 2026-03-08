export default defineEventHandler(async (event) => {
  const method = getMethod(event)
  const body = await readBody()
  
  try {
    const { subscribeToNewsletter } = useSupabase()
    
    if (method === 'POST') {
      if (body.action === 'subscribe') {
        const result = await subscribeToNewsletter(body.email, body.name)
        return { success: true, data: result }
      }
      
      if (body.action === 'unsubscribe') {
        return { success: true, message: 'Unsubscribed successfully' }
      }
    }
    
    return { success: false, error: 'Invalid action' }
  } catch (error) {
    console.error('Newsletter error:', error)
    return { success: false, error: 'Failed to process request' }
  }
})
