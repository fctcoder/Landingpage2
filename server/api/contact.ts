export default defineEventHandler(async (event) => {
  const body = await readBody(event)

  // Use the service role client on the server side so RLS is bypassed.
  // This is safe because this code only runs on the server — the service
  // role key is never exposed to the browser.
  const client = serverSupabaseServiceRole(event)

  try {
    const { data, error } = await client
      .from('contact_submissions')
      .insert({
        name: body.name,
        email: body.email,
        phone: body.phone || null,
        company: body.company || null,
        industry: body.industry || null,
        country: body.country || null,
        subject: body.subject || null,
        message: body.message,
        subscribe_newsletter: body.subscribe_newsletter || false,
        source: 'contact_form'
      })
      .select()
      .single()

    if (error) throw error

    return { success: true, data }
  } catch (error: any) {
    console.error('Contact submission error:', error)
    return {
      success: false,
      error: error?.message || 'Failed to submit contact form'
    }
  }
})

