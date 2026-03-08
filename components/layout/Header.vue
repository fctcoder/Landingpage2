<template>
  <header 
    ref="headerRef"
    :class="headerClasses"
  >
    <nav class="container-custom">
      <div class="flex items-center justify-between h-20">
        <NuxtLink to="/" class="flex items-center space-x-2">
          <div class="flex items-center">
            <svg class="w-10 h-10 text-primary-600" viewBox="0 0 40 40" fill="currentColor">
              <path d="M20 4L4 12v16l16 8 16-8V12L20 4zm0 2.5L32.5 13 20 19.5 7.5 13 20 6.5zM6 14.5l13 6.5v13l-13-6.5v-13zm28 0v13l-13 6.5v-13l13-6.5z"/>
            </svg>
            <span class="ml-2 text-2xl font-bold text-secondary-900">Spade<span class="text-primary-600">X</span></span>
          </div>
        </NuxtLink>

        <div class="hidden lg:flex items-center space-x-8">
          <NuxtLink 
            v-for="item in navigation" 
            :key="item.path"
            :to="item.path"
            class="nav-link"
            :class="{ 'text-primary-600': isActive(item.path) }"
          >
            {{ item.name }}
          </NuxtLink>
        </div>

        <div class="hidden lg:flex items-center space-x-4">
          <UiButton variant="outline" size="sm" to="/contact">
            Get a Quote
          </UiButton>
          <UiButton variant="primary" size="sm" to="/contact">
            Contact Us
          </UiButton>
        </div>

        <button 
          type="button"
          class="lg:hidden p-2 rounded-lg text-secondary-600 hover:bg-secondary-100"
          @click="mobileMenuOpen = !mobileMenuOpen"
        >
          <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path v-if="!mobileMenuOpen" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
            <path v-else stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
          </svg>
        </button>
      </div>

      <Transition
        enter-active-class="transition-all duration-300"
        enter-from-class="opacity-0 max-h-0"
        enter-to-class="opacity-100 max-h-screen"
        leave-active-class="transition-all duration-200"
        leave-from-class="opacity-100 max-h-screen"
        leave-to-class="opacity-0 max-h-0"
      >
        <div v-if="mobileMenuOpen" class="lg:hidden overflow-hidden">
          <div class="py-4 space-y-2 border-t border-secondary-200">
            <NuxtLink 
              v-for="item in navigation" 
              :key="item.path"
              :to="item.path"
              class="block px-4 py-2 text-secondary-600 hover:text-primary-600 hover:bg-primary-50 rounded-lg transition-colors"
              @click="mobileMenuOpen = false"
            >
              {{ item.name }}
            </NuxtLink>
            <div class="pt-4 px-4 space-y-2">
              <UiButton variant="outline" block to="/contact" @click="mobileMenuOpen = false">
                Get a Quote
              </UiButton>
              <UiButton variant="primary" block to="/contact" @click="mobileMenuOpen = false">
                Contact Us
              </UiButton>
            </div>
          </div>
        </div>
      </Transition>
    </nav>
  </header>
</template>

<script setup lang="ts">
const route = useRoute()
const mobileMenuOpen = ref(false)
const headerRef = ref<HTMLElement | null>(null)
const isScrolled = ref(false)

const navigation = [
  { name: 'Home', path: '/' },
  { name: 'About', path: '/about' },
  { name: 'Projects', path: '/projects' },
  { name: 'Products', path: '/products' },
  { name: 'Newsletter', path: '/newsletter' },
  { name: 'Investors', path: '/investors' }
]

const isActive = (path: string) => {
  if (path === '/') return route.path === '/'
  return route.path.startsWith(path)
}

const headerClasses = computed(() => {
  const base = 'fixed top-0 left-0 right-0 z-40 transition-all duration-300'
  const scrolled = isScrolled.value ? 'bg-white/95 backdrop-blur-md shadow-lg' : 'bg-transparent'
  return [base, scrolled]
})

onMounted(() => {
  const handleScroll = () => {
    isScrolled.value = window.scrollY > 20
  }
  window.addEventListener('scroll', handleScroll)
  onUnmounted(() => {
    window.removeEventListener('scroll', handleScroll)
  })
})

watch(() => route.path, () => {
  mobileMenuOpen.value = false
})
</script>

<style scoped>
.nav-link {
  @apply text-secondary-600 hover:text-primary-600 font-medium transition-colors relative;
}

.nav-link::after {
  content: '';
  @apply absolute bottom-0 left-0 w-0 h-0.5 bg-primary-600 transition-all duration-300;
}

.nav-link:hover::after,
.nav-link.text-primary-600::after {
  @apply w-full;
}
</style>
