# SpadeX Landing Page - Project Plan

End-of-line packaging automation company based in Malaysia, targeting international customers across medical devices, pharmacies, gloves, and FMCG industries.

---

## 1. Project Structure

```
landingpage/
├── docker/
│   ├── docker-compose.local.yml
│   ├── docker-compose.staging.yml
│   └── docker-compose.prod.yml
├── supabase/
│   └── migrations/
│       ├── 001_companies.sql
│       ├── 002_testimonials.sql
│       ├── 003_projects_products.sql
│       ├── 004_blog_posts.sql
│       ├── 005_newsletter_subscribers.sql
│       ├── 006_chat_messages.sql
│       ├── 007_investor_info.sql
│       └── 008_contact_submissions.sql
├── nuxt.config.ts
├── tailwind.config.ts
├── app.vue
├── pages/
│   ├── index.vue              # Landing page
│   ├── about.vue              # Company profile
│   ├── projects.vue           # Gallery - Past projects
│   ├── products.vue           # Gallery - Products
│   ├── newsletter.vue         # Blog listing
│   ├── newsletter/
│   │   └── [slug].vue         # Blog post detail
│   ├── investors.vue          # Investor info
│   └── contact.vue            # Contact page
├── components/
│   ├── layout/
│   │   ├── Header.vue
│   │   ├── Footer.vue
│   │   └── ChatBot.vue
│   ├── home/
│   │   ├── HeroSection.vue
│   │   ├── ServicesSection.vue
│   │   ├── TestimonialsSection.vue
│   │   ├── IndustriesSection.vue
│   │   └── CTASection.vue
│   ├── ui/
│   │   ├── Button.vue
│   │   ├── Card.vue
│   │   └── Modal.vue
│   └── galleries/
│       ├── ProjectCard.vue
│       └── ProductCard.vue
├── composables/
│   ├── useAnimations.ts
│   ├── useChat.ts
│   └── useSupabase.ts
├── server/
│   └── api/
│       ├── contact.ts
│       ├── newsletter.ts
│       └── chat.ts
├── assets/
│   ├── css/
│   │   └── main.css
│   └── images/
├── public/
│   └── favicon.ico
├── types/
│   └── index.ts
├── utils/
│   └── animations.ts
└── README.md
```

---

## 2. Database Schema (Supabase)

### Tables Overview

| Table | Purpose | Key Fields |
|-------|---------|------------|
| `testimonials` | Client testimonials | id, name, company, quote, rating, industry, created_at |
| `projects` | Past projects gallery | id, title, description, images[], industry, year, client, created_at |
| `products` | Product catalog | id, name, description, specs{}, images[], category, created_at |
| `blog_posts` | Newsletter/blog content | id, title, slug, content, excerpt, cover_image, published_at, author_id |
| `newsletter_subscribers` | Email subscriptions | id, email, subscribed_at, is_active |
| `chat_messages` | Chat history | id, session_id, message, sender_type, created_at |
| `chat_sessions` | Chat sessions | id, visitor_info{}, status, created_at, updated_at |
| `contact_submissions` | Form submissions | id, name, email, company, message, industry, created_at |
| `investor_info` | Investor relations | id, title, content, document_url, type, created_at |

### Migration Files

```sql
-- 001_companies.sql
CREATE TABLE companies (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  logo_url TEXT,
  industry VARCHAR(100),
  website VARCHAR(255),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 002_testimonials.sql
CREATE TABLE testimonials (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  position VARCHAR(255),
  company VARCHAR(255),
  quote TEXT NOT NULL,
  rating INTEGER CHECK (rating >= 1 AND rating <= 5),
  industry VARCHAR(100),
  avatar_url TEXT,
  is_featured BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 003_projects_products.sql
CREATE TABLE projects (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title VARCHAR(255) NOT NULL,
  description TEXT,
  images TEXT[],
  industry VARCHAR(100),
  year INTEGER,
  client_name VARCHAR(255),
  project_type VARCHAR(100),
  is_featured BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE products (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  description TEXT,
  specs JSONB,
  images TEXT[],
  category VARCHAR(100),
  price_range VARCHAR(100),
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 004_blog_posts.sql
CREATE TABLE blog_posts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title VARCHAR(255) NOT NULL,
  slug VARCHAR(255) UNIQUE NOT NULL,
  content TEXT,
  excerpt TEXT,
  cover_image TEXT,
  category VARCHAR(100),
  tags TEXT[],
  author_name VARCHAR(255),
  published_at TIMESTAMPTZ,
  is_published BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 005_newsletter_subscribers.sql
CREATE TABLE newsletter_subscribers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email VARCHAR(255) UNIQUE NOT NULL,
  name VARCHAR(255),
  subscribed_at TIMESTAMPTZ DEFAULT NOW(),
  is_active BOOLEAN DEFAULT TRUE,
  unsubscribed_at TIMESTAMPTZ
);

-- 006_chat_messages.sql
CREATE TABLE chat_sessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  visitor_name VARCHAR(255),
  visitor_email VARCHAR(255),
  visitor_phone VARCHAR(50),
  status VARCHAR(50) DEFAULT 'active',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE chat_messages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id UUID REFERENCES chat_sessions(id),
  message TEXT NOT NULL,
  sender_type VARCHAR(20) CHECK (sender_type IN ('visitor', 'admin')),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 007_investor_info.sql
CREATE TABLE investor_info (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title VARCHAR(255) NOT NULL,
  content TEXT,
  document_url TEXT,
  type VARCHAR(50) CHECK (type IN ('report', 'presentation', 'financial', 'governance')),
  year INTEGER,
  quarter VARCHAR(10),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 008_contact_submissions.sql
CREATE TABLE contact_submissions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  phone VARCHAR(50),
  company VARCHAR(255),
  industry VARCHAR(100),
  message TEXT NOT NULL,
  status VARCHAR(50) DEFAULT 'new',
  created_at TIMESTAMPTZ DEFAULT NOW()
);
```

---

## 3. Page Breakdown

### Landing Page (index.vue)

| Section | Content | Features |
|---------|---------|----------|
| Hero | Company tagline, main CTA | Background animation, scroll indicator |
| Services | One-stop solution highlights | Icon cards, hover animations |
| Industries | Medical, Pharmacy, Gloves, FMCG | Filter tabs, industry cards |
| Testimonials | Client reviews carousel | Auto-scroll, rating stars |
| CTA | "Get a Quote" section | Form modal, contact info |
| Contact | Quick contact form | Validation, Supabase submission |

### About Us (about.vue)

| Section | Content |
|---------|---------|
| Company Profile | Mission, Vision, Values |
| Story Timeline | Company history milestones |
| Team | Key personnel (optional) |
| Certifications | ISO, industry certifications |
| Why Choose Us | Unique selling points |

### Projects Gallery (projects.vue)

| Feature | Implementation |
|---------|---------------|
| Filter | By industry, year, type |
| Cards | Image, title, client, industry |
| Modal | Project details, image gallery |
| Pagination | Infinite scroll or pagination |

### Products Gallery (products.vue)

| Feature | Implementation |
|---------|---------------|
| Categories | Packaging machines, conveyors, etc. |
| Cards | Product image, name, key specs |
| Detail Modal | Full specs, brochure download |
| Inquiry CTA | Contact form pre-filled |

### Newsletter/Blog (newsletter.vue)

| Feature | Implementation |
|---------|---------------|
| Article List | Cards with cover, excerpt, date |
| Categories | Filter by topic |
| Search | Full-text search |
| Subscribe | Email capture form |
| Single Post | Rich content, share buttons |

### Investors (investors.vue)

| Section | Content |
|---------|---------|
| Overview | Company financial highlights |
| Reports | Annual reports, quarterly updates |
| Governance | Board structure, policies |
| Contact | Investor relations contact |

### Contact (contact.vue)

| Feature | Implementation |
|---------|---------------|
| Form | Name, email, phone, company, industry, message |
| Map | Google Maps embed (Malaysia HQ) |
| Office Info | Address, phone, email, hours |
| Social Links | LinkedIn, etc. |

---

## 4. Key Features Implementation

### Chatbot (Custom Supabase)

```
┌─────────────────────────────────────┐
│  Floating Button (bottom-right)     │
│  ┌─────────────────────────────┐    │
│  │ 💬 Chat with us            │    │
│  └─────────────────────────────┘    │
│                                     │
│  On Click:                          │
│  ┌─────────────────────────────┐    │
│  │ SpadeX Support        ─ ✕  │    │
│  ├─────────────────────────────┤    │
│  │ [Messages...]               │    │
│  │                             │    │
│  │ [Type message...] [Send]    │    │
│  └─────────────────────────────┘    │
└─────────────────────────────────────┘
```

**Implementation:**
- Real-time messaging via Supabase Realtime
- Session tracking for returning visitors
- Admin panel for support team
- Offline form capture

### Animations (Anime.js)

| Animation Type | Usage |
|----------------|-------|
| Scroll reveal | Sections fade/slide in on scroll |
| Page transitions | Fade between route changes |
| Hover effects | Cards, buttons, links |
| Loading states | Skeleton screens, spinners |
| Counter animations | Stats/numbers counting up |
| Carousel | Testimonials auto-scroll |

### Mobile Responsive Design

| Breakpoint | Adjustments |
|------------|-------------|
| Mobile (<640px) | Hamburger menu, stacked layouts, full-width cards |
| Tablet (640-1024px) | 2-column grids, adjusted spacing |
| Desktop (>1024px) | Full navigation, multi-column layouts |

**Key Mobile Considerations:**
- Touch-friendly button sizes (min 44px)
- Swipe gestures for galleries
- Simplified navigation
- Optimized images (lazy loading)
- Reduced animations for performance

---

## 5. Docker Compose Environments

### Local Development

```yaml
# docker-compose.local.yml
services:
  nuxt:
    build:
      context: .
      dockerfile: Dockerfile.dev
    ports:
      - "3000:3000"
    volumes:
      - .:/app
      - /app/node_modules
    environment:
      - NUXT_PUBLIC_SUPABASE_URL=${SUPABASE_URL}
      - NUXT_PUBLIC_SUPABASE_KEY=${SUPABASE_ANON_KEY}
    command: npm run dev

  supabase:
    image: supabase/supabase-local
    ports:
      - "54321:54321"
    environment:
      - POSTGRES_PASSWORD=postgres
```

### Staging

```yaml
# docker-compose.staging.yml
services:
  nuxt:
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - "3000:3000"
    environment:
      - NUXT_PUBLIC_SUPABASE_URL=${STAGING_SUPABASE_URL}
      - NUXT_PUBLIC_SUPABASE_KEY=${STAGING_SUPABASE_ANON_KEY}
      - NODE_ENV=staging
```

### Production

```yaml
# docker-compose.prod.yml
services:
  nuxt:
    build:
      context: .
      dockerfile: Dockerfile
    restart: always
    environment:
      - NUXT_PUBLIC_SUPABASE_URL=${PROD_SUPABASE_URL}
      - NUXT_PUBLIC_SUPABASE_KEY=${PROD_SUPABASE_ANON_KEY}
      - NODE_ENV=production

  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
      - ./ssl:/etc/nginx/ssl
    depends_on:
      - nuxt
```

---

## 6. Development Phases

### Phase 1: Project Setup (Days 1-2)
- [ ] Initialize Nuxt 3 project
- [ ] Configure TailwindCSS with custom theme (Green & White)
- [ ] Setup Supabase client
- [ ] Create Docker configurations
- [ ] Setup base layout (Header, Footer)
- [ ] Configure Anime.js

### Phase 2: Landing Page (Days 3-5)
- [ ] Hero section with animations
- [ ] Services section
- [ ] Industries section
- [ ] Testimonials carousel
- [ ] CTA section
- [ ] Contact form
- [ ] Scroll animations

### Phase 3: About & Galleries (Days 6-8)
- [ ] About Us page
- [ ] Projects gallery with filtering
- [ ] Products gallery
- [ ] Image lightbox/modals

### Phase 4: Blog & Newsletter (Days 9-11)
- [ ] Blog listing page
- [ ] Blog post detail page
- [ ] Newsletter subscription
- [ ] Admin UI for content management

### Phase 5: Investors & Contact (Days 12-13)
- [ ] Investors page
- [ ] Contact page with map
- [ ] Form validations

### Phase 6: Chatbot & Polish (Days 14-16)
- [ ] Chatbot component
- [ ] Real-time messaging
- [ ] Mobile optimization
- [ ] Performance optimization
- [ ] Testing & bug fixes

---

## 7. Tech Stack Summary

| Layer | Technology | Purpose |
|-------|------------|---------|
| Framework | Nuxt 3 | SSR, routing, SEO |
| CSS | TailwindCSS | Utility-first styling |
| Animations | Anime.js | Page transitions, scroll effects |
| Database | Supabase (PostgreSQL) | Data storage, real-time |
| Auth | Supabase Auth | Admin authentication |
| Realtime | Supabase Realtime | Chat functionality |
| Storage | Supabase Storage | Images, documents |
| Container | Docker | Development & deployment |
| Reverse Proxy | Nginx | Production serving |

---

## 8. Color Palette (Green & White Theme)

```css
/* Tailwind Config */
colors: {
  primary: {
    50: '#f0fdf4',
    100: '#dcfce7',
    200: '#bbf7d0',
    300: '#86efac',
    400: '#4ade80',
    500: '#22c55e',  /* Main brand green */
    600: '#16a34a',
    700: '#15803d',
    800: '#166534',
    900: '#14532d',
  },
  secondary: {
    50: '#fafafa',
    100: '#f4f4f5',
    200: '#e4e4e7',
    300: '#d4d4d8',
    400: '#a1a1aa',
    500: '#71717a',
    600: '#52525b',
    700: '#3f3f46',
    800: '#27272a',
    900: '#18181b',
  }
}
```

---

## 9. Folder Structure for Assets

```
assets/
├── css/
│   └── main.css          # Global styles, Tailwind imports
├── images/
│   ├── logo/
│   │   ├── spadex-logo.svg
│   │   └── spadex-logo-white.svg
│   ├── hero/
│   │   └── hero-bg.jpg
│   ├── industries/
│   │   ├── medical-devices.jpg
│   │   ├── pharmacy.jpg
│   │   ├── gloves.jpg
│   │   └── fmcg.jpg
│   ├── icons/
│   │   └── [various icons]
│   └── team/
│       └── [team photos]
└── fonts/
    └── [custom fonts if needed]
```

---

## 10. API Endpoints

| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/api/contact` | POST | Submit contact form |
| `/api/newsletter/subscribe` | POST | Subscribe to newsletter |
| `/api/newsletter/unsubscribe` | POST | Unsubscribe |
| `/api/chat/session` | POST | Create chat session |
| `/api/chat/message` | POST | Send chat message |
| `/api/chat/messages/:sessionId` | GET | Get chat history |

---

## 11. SEO Configuration

```typescript
// nuxt.config.ts
export default defineNuxtConfig({
  app: {
    head: {
      title: 'SpadeX - End-of-Line Packaging Automation',
      meta: [
        { name: 'description', content: 'Leading end-of-line packaging automation solutions in Malaysia for medical devices, pharmaceuticals, gloves, and FMCG industries.' },
        { name: 'keywords', content: 'packaging automation, Malaysia, medical devices, FMCG, end-of-line packaging' },
        { property: 'og:title', content: 'SpadeX - Packaging Automation' },
        { property: 'og:description', content: 'One-stop solution for packaging automation' },
        { property: 'og:type', content: 'website' },
        { name: 'twitter:card', content: 'summary_large_image' },
      ],
      link: [
        { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' },
      ],
    },
  },
});
```

---

## 12. Deployment Checklist

- [ ] Environment variables configured
- [ ] Supabase production project created
- [ ] SSL certificates installed
- [ ] Domain DNS configured
- [ ] CDN setup for static assets
- [ ] Monitoring/logging configured
- [ ] Backup strategy implemented
- [ ] Rate limiting on API endpoints
- [ ] CSP headers configured

---

## Contact & Support

**Project:** SpadeX Landing Page  
**Location:** Malaysia  
**Target Markets:** International (Medical Devices, Pharmacies, Gloves, FMCG)
