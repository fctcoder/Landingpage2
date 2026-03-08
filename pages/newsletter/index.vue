<template>
  <div>
    <section class="relative py-24 bg-gradient-to-br from-secondary-900 via-secondary-800 to-primary-900 overflow-hidden">
      <div class="absolute inset-0 bg-[url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNjAiIGhlaWdodD0iNjAiIHZpZXdCb3g9IjAgMCA2MCA2MCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPjxnIGZpbGw9IiNmZmYiIGZpbGwtb3BhY2l0eT0iMC4wMyI+PGNpcmNsZSBjeD0iMzAiIGN5PSIzMCIgcj0iMiIvPjwvZz48L2c+PC9zdmc+')] opacity-50"></div>
      <div class="container-custom relative z-10">
        <div class="max-w-3xl">
          <span class="inline-block px-4 py-1 bg-primary-500/20 text-primary-300 rounded-full text-sm font-medium mb-4">
            Newsletter
          </span>
          <h1 class="text-4xl md:text-5xl lg:text-6xl font-bold text-white mb-6">
            Latest <span class="text-primary-400">Insights</span> & News
          </h1>
          <p class="text-xl text-secondary-300">
            Stay updated with the latest trends, insights, and news in packaging automation.
          </p>
        </div>
      </div>
    </section>

    <section class="section-padding bg-white">
      <div class="container-custom">
        <div class="flex flex-col lg:flex-row gap-8">
          <div class="lg:w-2/3">
            <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4 mb-8">
              <div class="flex flex-wrap gap-2">
                <button 
                  v-for="cat in categories" 
                  :key="cat"
                  @click="selectedCategory = cat"
                  class="px-4 py-2 rounded-lg text-sm font-medium transition-colors"
                  :class="selectedCategory === cat ? 'bg-primary-600 text-white' : 'bg-secondary-100 text-secondary-600 hover:bg-secondary-200'"
                >
                  {{ cat }}
                </button>
              </div>
            </div>

            <div v-if="filteredPosts.length > 0" class="space-y-8">
              <article 
                v-for="post in filteredPosts" 
                :key="post.id"
                class="bg-white rounded-xl shadow-lg overflow-hidden hover:shadow-xl transition-shadow"
              >
                <NuxtLink :to="`/newsletter/${post.slug}`" class="flex flex-col md:flex-row">
                  <div class="md:w-1/3 aspect-video md:aspect-auto">
                    <img 
                      v-if="post.cover_image"
                      :src="post.cover_image"
                      :alt="post.title"
                      class="w-full h-full object-cover"
                    >
                    <div v-else class="w-full h-full bg-gradient-to-br from-primary-100 to-primary-200 flex items-center justify-center">
                      <svg class="w-12 h-12 text-primary-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1" d="M19 20H5a2 2 0 01-2-2V6a2 2 0 012-2h10a2 2 0 012 2v1m2 13a2 2 0 01-2-2V7m2 13a2 2 0 002-2V9a2 2 0 00-2-2h-2m-4-3H9M7 16h6M7 8h6v4H7V8z" />
                      </svg>
                    </div>
                  </div>
                  <div class="p-6 md:w-2/3">
                    <div class="flex items-center gap-2 mb-2">
                      <span v-if="post.category" class="px-2 py-1 bg-primary-100 text-primary-700 text-xs font-medium rounded">
                        {{ post.category }}
                      </span>
                      <span class="text-secondary-500 text-sm">{{ formatDate(post.published_at) }}</span>
                    </div>
                    <h2 class="text-xl font-semibold text-secondary-900 mb-2 hover:text-primary-600 transition-colors">
                      {{ post.title }}
                    </h2>
                    <p class="text-secondary-600 line-clamp-2">{{ post.excerpt }}</p>
                    <div class="mt-4 flex items-center text-primary-600 font-medium text-sm">
                      Read more
                      <svg class="w-4 h-4 ml-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 8l4 4m0 0l-4 4m4-4H3" />
                      </svg>
                    </div>
                  </div>
                </NuxtLink>
              </article>
            </div>

            <div v-else class="text-center py-16">
              <svg class="w-16 h-16 text-secondary-300 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1" d="M19 20H5a2 2 0 01-2-2V6a2 2 0 012-2h10a2 2 0 012 2v1m2 13a2 2 0 01-2-2V7m2 13a2 2 0 002-2V9a2 2 0 00-2-2h-2m-4-3H9M7 16h6M7 8h6v4H7V8z" />
              </svg>
              <h3 class="text-lg font-medium text-secondary-900 mb-2">No articles found</h3>
              <p class="text-secondary-600">Check back soon for new content.</p>
            </div>
          </div>

          <aside class="lg:w-1/3">
            <div class="bg-primary-50 rounded-xl p-6 mb-8">
              <h3 class="text-lg font-semibold text-secondary-900 mb-4">Subscribe to Newsletter</h3>
              <p class="text-secondary-600 text-sm mb-4">Get the latest insights delivered to your inbox.</p>
              <form @submit.prevent="subscribeNewsletter" class="space-y-3">
                <input 
                  v-model="subscriberEmail"
                  type="email"
                  placeholder="Enter your email"
                  required
                  class="w-full px-4 py-3 border border-secondary-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
                >
                <UiButton type="submit" variant="primary" block :loading="isSubscribing">
                  Subscribe
                </UiButton>
              </form>
            </div>

            <div class="bg-white rounded-xl shadow-lg p-6 mb-8">
              <h3 class="text-lg font-semibold text-secondary-900 mb-4">Categories</h3>
              <ul class="space-y-2">
                <li v-for="cat in categories.slice(1)" :key="cat">
                  <button 
                    @click="selectedCategory = cat"
                    class="flex items-center justify-between w-full text-secondary-600 hover:text-primary-600 transition-colors"
                  >
                    <span>{{ cat }}</span>
                    <span class="text-sm text-secondary-400">{{ getPostCount(cat) }}</span>
                  </button>
                </li>
              </ul>
            </div>

            <div class="bg-white rounded-xl shadow-lg p-6">
              <h3 class="text-lg font-semibold text-secondary-900 mb-4">Recent Posts</h3>
              <ul class="space-y-4">
                <li v-for="post in recentPosts" :key="post.id">
                  <NuxtLink :to="`/newsletter/${post.slug}`" class="flex items-start gap-3 group">
                    <div class="w-16 h-16 bg-secondary-100 rounded-lg flex-shrink-0 overflow-hidden">
                      <img 
                        v-if="post.cover_image"
                        :src="post.cover_image"
                        :alt="post.title"
                        class="w-full h-full object-cover"
                      >
                    </div>
                    <div>
                      <h4 class="text-sm font-medium text-secondary-900 group-hover:text-primary-600 transition-colors line-clamp-2">
                        {{ post.title }}
                      </h4>
                      <p class="text-xs text-secondary-500 mt-1">{{ formatDate(post.published_at) }}</p>
                    </div>
                  </NuxtLink>
                </li>
              </ul>
            </div>
          </aside>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
import type { BlogPost } from '~/types'

useHead({
  title: 'Newsletter - SpadeX',
  meta: [
    { name: 'description', content: 'Stay updated with the latest trends, insights, and news in packaging automation.' }
  ]
})

const selectedCategory = ref('All')
const subscriberEmail = ref('')
const isSubscribing = ref(false)

const categories = ['All', 'Industry News', 'Technology', 'Case Studies', 'Events']

const posts: BlogPost[] = [
  {
    id: '1',
    title: 'The Future of Packaging Automation in Medical Device Industry',
    slug: 'future-packaging-automation-medical-device',
    excerpt: 'Discover how automation is transforming the medical device packaging landscape with improved efficiency and compliance.',
    content: '',
    category: 'Industry News',
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
    author_name: 'Lisa Wong',
    published_at: '2024-02-15',
    is_published: true,
    created_at: '2024-02-15',
    updated_at: '2024-02-15'
  },
  {
    id: '5',
    title: 'PACK EXPO 2024: What to Expect',
    slug: 'pack-expo-2024-preview',
    excerpt: 'Get a preview of the upcoming PACK EXPO 2024 and what SpadeX has in store for visitors.',
    content: '',
    category: 'Events',
    author_name: 'David Kim',
    published_at: '2024-02-10',
    is_published: true,
    created_at: '2024-02-10',
    updated_at: '2024-02-10'
  }
]

const filteredPosts = computed(() => {
  if (selectedCategory.value === 'All') return posts
  return posts.filter(p => p.category === selectedCategory.value)
})

const recentPosts = computed(() => posts.slice(0, 3))

const getPostCount = (category: string) => {
  return posts.filter(p => p.category === category).length
}

const formatDate = (dateString?: string) => {
  if (!dateString) return ''
  const date = new Date(dateString)
  return date.toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' })
}

const subscribeNewsletter = async () => {
  isSubscribing.value = true
  try {
    console.log('Subscribing:', subscriberEmail.value)
    subscriberEmail.value = ''
  } catch (error) {
    console.error('Failed to subscribe:', error)
  } finally {
    isSubscribing.value = false
  }
}
</script>
