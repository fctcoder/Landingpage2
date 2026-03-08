export interface Testimonial {
  id: string
  name: string
  position?: string
  company?: string
  quote: string
  rating: number
  industry?: string
  avatar_url?: string
  is_featured?: boolean
  created_at: string
}

export interface Project {
  id: string
  title: string
  description?: string
  images: string[]
  industry?: string
  year?: number
  client_name?: string
  project_type?: string
  is_featured?: boolean
  created_at: string
}

export interface Product {
  id: string
  name: string
  description?: string
  specs?: Record<string, unknown>
  images: string[]
  category?: string
  price_range?: string
  is_active?: boolean
  created_at: string
}

export interface BlogPost {
  id: string
  title: string
  slug: string
  content?: string
  excerpt?: string
  cover_image?: string
  category?: string
  tags?: string[]
  author_name?: string
  published_at?: string
  is_published?: boolean
  created_at: string
  updated_at: string
}

export interface NewsletterSubscriber {
  id: string
  email: string
  name?: string
  subscribed_at: string
  is_active: boolean
  unsubscribed_at?: string
}

export interface ChatSession {
  id: string
  visitor_name?: string
  visitor_email?: string
  visitor_phone?: string
  status: string
  created_at: string
  updated_at: string
}

export interface ChatMessage {
  id: string
  session_id: string
  message: string
  sender_type: 'visitor' | 'admin'
  created_at: string
}

export interface InvestorInfo {
  id: string
  title: string
  content?: string
  document_url?: string
  type: 'report' | 'presentation' | 'financial' | 'governance'
  year?: number
  quarter?: string
  created_at: string
}

export interface ContactSubmission {
  id: string
  name: string
  email: string
  phone?: string
  company?: string
  industry?: string
  country?: string
  subject?: string
  message: string
  subscribe_newsletter: boolean
  status: string
  created_at: string
}

export interface Service {
  id: string
  title: string
  description: string
  icon: string
  features: string[]
}

export interface Industry {
  id: string
  name: string
  description: string
  image: string
  icon: string
}

export interface TeamMember {
  id: string
  name: string
  position: string
  image?: string
  bio?: string
  linkedin?: string
}

export interface Certification {
  id: string
  name: string
  description?: string
  image?: string
  year?: number
}

export interface TimelineEvent {
  id: string
  year: number
  title: string
  description: string
}

export interface NavLink {
  name: string
  path: string
  children?: NavLink[]
}

export interface SocialLink {
  name: string
  url: string
  icon: string
}

export interface OfficeLocation {
  name: string
  address: string
  phone?: string
  email?: string
  coordinates?: {
    lat: number
    lng: number
  }
}
