import { createClient } from '@supabase/supabase-js'
import type { Database } from '~/types/database'

// useSupabaseClient is auto-imported from @nuxtjs/supabase

export const useSupabase = () => {
  const client = useSupabaseClient()
  
  const fetchTestimonials = async (featured?: boolean) => {
    let query = client.from('testimonials').select('*').order('created_at', { ascending: false })
    if (featured) {
      query = query.eq('is_featured', true)
    }
    const { data, error } = await query
    if (error) throw error
    return data
  }
  
  const fetchProjects = async (filters?: { industry?: string; year?: number }) => {
    let query = client.from('projects').select('*').order('created_at', { ascending: false })
    if (filters?.industry) {
      query = query.eq('industry', filters.industry)
    }
    if (filters?.year) {
      query = query.eq('year', filters.year)
    }
    const { data, error } = await query
    if (error) throw error
    return data
  }
  
  const fetchProducts = async (category?: string) => {
    let query = client.from('products').select('*').eq('is_active', true).order('created_at', { ascending: false })
    if (category) {
      query = query.eq('category', category)
    }
    const { data, error } = await query
    if (error) throw error
    return data
  }
  
  const fetchBlogPosts = async (limit?: number, category?: string) => {
    let query = client
      .from('blog_posts')
      .select('*')
      .eq('is_published', true)
      .order('published_at', { ascending: false })
    if (category) {
      query = query.eq('category', category)
    }
    if (limit) {
      query = query.limit(limit)
    }
    const { data, error } = await query
    if (error) throw error
    return data
  }
  
  const fetchBlogPost = async (slug: string) => {
    const { data, error } = await client
      .from('blog_posts')
      .select('*')
      .eq('slug', slug)
      .eq('is_published', true)
      .single()
    if (error) throw error
    return data
  }
  
  const subscribeToNewsletter = async (email: string, name?: string) => {
    const { data, error } = await client
      .from('newsletter_subscribers')
      .insert({ email, name })
      .select()
      .single()
    if (error) throw error
    return data
  }
  
  const submitContact = async (submission: Omit<ContactSubmission, 'id' | 'status' | 'created_at'>) => {
    const { data, error } = await client
      .from('contact_submissions')
      .insert(submission)
      .select()
      .single()
    if (error) throw error
    return data
  }
  
  const fetchInvestorInfo = async (type?: string) => {
    let query = client.from('investor_info').select('*').order('created_at', { ascending: false })
    if (type) {
      query = query.eq('type', type)
    }
    const { data, error } = await query
    if (error) throw error
    return data
  }
  
  return {
    client,
    fetchTestimonials,
    fetchProjects,
    fetchProducts,
    fetchBlogPosts,
    fetchBlogPost,
    subscribeToNewsletter,
    submitContact,
    fetchInvestorInfo
  }
}
