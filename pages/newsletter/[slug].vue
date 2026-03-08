<template>
  <div v-if="post">
    <section class="relative py-24 bg-gradient-to-br from-secondary-900 via-secondary-800 to-primary-900 overflow-hidden">
      <div class="absolute inset-0 bg-[url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNjAiIGhlaWdodD0iNjAiIHZpZXdCb3g9IjAgMCA2MCA2MCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPjxnIGZpbGw9IiNmZmYiIGZpbGwtb3BhY2l0eT0iMC4wMyI+PGNpcmNsZSBjeD0iMzAiIGN5PSIzMCIgcj0iMiIvPjwvZz48L2c+PC9zdmc+')] opacity-50"></div>
      <div class="container-custom relative z-10">
        <div class="max-w-4xl">
          <NuxtLink to="/newsletter" class="inline-flex items-center text-primary-400 hover:text-primary-300 mb-6 transition-colors">
            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
            </svg>
            Back to Newsletter
          </NuxtLink>
          
          <div class="flex items-center gap-2 mb-4">
            <span v-if="post.category" class="px-3 py-1 bg-primary-500/20 text-primary-300 rounded-full text-sm font-medium">
              {{ post.category }}
            </span>
            <span class="text-secondary-400">{{ formatDate(post.published_at) }}</span>
          </div>
          
          <h1 class="text-3xl md:text-4xl lg:text-5xl font-bold text-white mb-6">
            {{ post.title }}
          </h1>
          
          <div class="flex items-center gap-4">
            <div class="w-12 h-12 bg-primary-500 rounded-full flex items-center justify-center">
              <span class="text-white font-semibold">{{ post.author_name?.charAt(0) || 'S' }}</span>
            </div>
            <div>
              <p class="text-white font-medium">{{ post.author_name || 'SpadeX Team' }}</p>
              <p class="text-secondary-400 text-sm">{{ post.reading_time || 5 }} min read</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="section-padding bg-white">
      <div class="container-custom">
        <div class="max-w-4xl mx-auto">
          <div v-if="post.cover_image" class="aspect-video rounded-xl overflow-hidden mb-8">
            <img :src="post.cover_image" :alt="post.title" class="w-full h-full object-cover">
          </div>
          
          <div class="prose prose-lg max-w-none">
            <p class="text-xl text-secondary-600 mb-8">{{ post.excerpt }}</p>
            
            <div v-if="post.content" v-html="post.content"></div>
            
            <div v-else class="space-y-6">
              <p class="text-secondary-700 leading-relaxed">
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
              </p>
              <p class="text-secondary-700 leading-relaxed">
                Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
              </p>
              <h2 class="text-2xl font-bold text-secondary-900 mt-8">Key Takeaways</h2>
              <ul class="list-disc list-inside space-y-2 text-secondary-700">
                <li>Automation is transforming the packaging industry</li>
                <li>AI and machine learning are enabling smarter quality control</li>
                <li>Sustainability is driving innovation in packaging materials</li>
                <li>Integration with Industry 4.0 is becoming essential</li>
              </ul>
              <p class="text-secondary-700 leading-relaxed">
                Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.
              </p>
            </div>
          </div>

          <div v-if="post.tags && post.tags.length > 0" class="mt-8 pt-8 border-t border-secondary-200">
            <h4 class="text-sm font-medium text-secondary-900 mb-3">Tags</h4>
            <div class="flex flex-wrap gap-2">
              <span 
                v-for="tag in post.tags" 
                :key="tag"
                class="px-3 py-1 bg-secondary-100 text-secondary-700 text-sm rounded-full"
              >
                {{ tag }}
              </span>
            </div>
          </div>

          <div class="mt-8 pt-8 border-t border-secondary-200">
            <h4 class="text-sm font-medium text-secondary-900 mb-3">Share this article</h4>
            <div class="flex gap-3">
              <button class="p-2 bg-secondary-100 rounded-lg hover:bg-secondary-200 transition-colors">
                <svg class="w-5 h-5 text-secondary-600" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"/>
                </svg>
              </button>
              <button class="p-2 bg-secondary-100 rounded-lg hover:bg-secondary-200 transition-colors">
                <svg class="w-5 h-5 text-secondary-600" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M19 0h-14c-2.761 0-5 2.239-5 5v14c0 2.761 2.239 5 5 5h14c2.762 0 5-2.239 5-5v-14c0-2.761-2.238-5-5-5zm-11 19h-3v-11h3v11zm-1.5-12.268c-.966 0-1.75-.79-1.75-1.764s.784-1.764 1.75-1.764 1.75.79 1.75 1.764-.783 1.764-1.75 1.764zm13.5 12.268h-3v-5.604c0-3.368-4-3.113-4 0v5.604h-3v-11h3v1.765c1.396-2.586 7-2.777 7 2.476v6.759z"/>
                </svg>
              </button>
              <button class="p-2 bg-secondary-100 rounded-lg hover:bg-secondary-200 transition-colors">
                <svg class="w-5 h-5 text-secondary-600" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M24 4.557c-.883.392-1.832.656-2.828.775 1.017-.609 1.798-1.574 2.165-2.724-.951.564-2.005.974-3.127 1.195-.897-.957-2.178-1.555-3.594-1.555-3.179 0-5.515 2.966-4.797 6.045-4.091-.205-7.719-2.165-10.148-5.144-1.29 2.213-.669 5.108 1.523 6.574-.806-.026-1.566-.247-2.229-.616-.054 2.281 1.581 4.415 3.949 4.89-.693.188-1.452.232-2.224.084.626 1.956 2.444 3.379 4.6 3.419-2.07 1.623-4.678 2.348-7.29 2.04 2.179 1.397 4.768 2.212 7.548 2.212 9.142 0 14.307-7.721 13.995-14.646.962-.695 1.797-1.562 2.457-2.549z"/>
                </svg>
              </button>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="section-padding bg-secondary-50">
      <div class="container-custom">
        <div class="max-w-4xl mx-auto">
          <h2 class="text-2xl font-bold text-secondary-900 mb-8">Related Articles</h2>
          <div class="grid md:grid-cols-3 gap-6">
            <article 
              v-for="relatedPost in relatedPosts" 
              :key="relatedPost.id"
              class="bg-white rounded-xl shadow-lg overflow-hidden"
            >
              <NuxtLink :to="`/newsletter/${relatedPost.slug}`">
                <div class="aspect-video bg-secondary-100">
                  <img 
                    v-if="relatedPost.cover_image"
                    :src="relatedPost.cover_image"
                    :alt="relatedPost.title"
                    class="w-full h-full object-cover"
                  >
                </div>
                <div class="p-4">
                  <h3 class="font-semibold text-secondary-900 line-clamp-2 hover:text-primary-600 transition-colors">
                    {{ relatedPost.title }}
                  </h3>
                  <p class="text-sm text-secondary-500 mt-2">{{ formatDate(relatedPost.published_at) }}</p>
                </div>
              </NuxtLink>
            </article>
          </div>
        </div>
      </div>
    </section>
  </div>
  
  <div v-else class="min-h-screen flex items-center justify-center">
    <div class="text-center">
      <h1 class="text-2xl font-bold text-secondary-900 mb-4">Article Not Found</h1>
      <UiButton variant="primary" to="/newsletter">Back to Newsletter</UiButton>
    </div>
  </div>
</template>

<script setup lang="ts">
import type { BlogPost } from '~/types'

const route = useRoute()
const slug = route.params.slug as string

const posts: BlogPost[] = [
  {
    id: '1',
    title: 'The Future of Packaging Automation in Medical Device Industry',
    slug: 'future-packaging-automation-medical-device',
    excerpt: 'Discover how automation is transforming the medical device packaging landscape with improved efficiency and compliance.',
    content: '',
    category: 'Industry News',
    tags: ['Medical Devices', 'Automation', 'Industry 4.0'],
    author_name: 'John Smith',
    published_at: '2024-03-01',
    is_published: true,
    created_at: '2024-03-01',
    updated_at: '2024-03-01'
  },
  {
    id: '2',
    title: 'AI-Powered Quality Inspection: A Game Changer',
    slug: 'ai-quality-inspection-game-changer',
    excerpt: 'Learn how artificial intelligence is revolutionizing quality inspection in packaging lines.',
    content: '',
    category: 'Technology',
    tags: ['AI', 'Quality Control', 'Innovation'],
    author_name: 'Sarah Chen',
    published_at: '2024-02-28',
    is_published: true,
    created_at: '2024-02-28',
    updated_at: '2024-02-28'
  },
  {
    id: '3',
    title: 'SpadeX Expands to European Market',
    slug: 'spadex-expands-european-market',
    excerpt: 'SpadeX announces strategic expansion into the European market with new partnerships and facilities.',
    content: '',
    category: 'Industry News',
    tags: ['Expansion', 'Europe', 'Growth'],
    author_name: 'Michael Thompson',
    published_at: '2024-02-20',
    is_published: true,
    created_at: '2024-02-20',
    updated_at: '2024-02-20'
  },
  {
    id: '4',
    title: 'How We Helped GloveMaster Increase Production by 40%',
    slug: 'casestudy-glovemaster-production-increase',
    excerpt: 'A detailed case study on how SpadeX solutions helped a leading glove manufacturer boost their production efficiency.',
    content: '',
    category: 'Case Studies',
    tags: ['Case Study', 'Gloves', 'Efficiency'],
    author_name: 'Lisa Wong',
    published_at: '2024-02-15',
    is_published: true,
    created_at: '2024-02-15',
    updated_at: '2024-02-15'
  }
]

const post = computed(() => posts.find(p => p.slug === slug))

const relatedPosts = computed(() => {
  if (!post.value) return []
  return posts.filter(p => p.id !== post.value?.id && p.category === post.value?.category).slice(0, 3)
})

useHead({
  title: computed(() => post.value ? `${post.value.title} - SpadeX` : 'Article Not Found - SpadeX'),
  meta: [
    { name: 'description', content: computed(() => post.value?.excerpt || 'Article not found') }
  ]
})

const formatDate = (dateString?: string) => {
  if (!dateString) return ''
  const date = new Date(dateString)
  return date.toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' })
}
</script>
