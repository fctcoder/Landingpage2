<template>
  <section class="relative min-h-screen flex items-center overflow-hidden">
    <div class="absolute inset-0 bg-gradient-to-br from-secondary-900 via-secondary-800 to-primary-900">
      <div class="absolute inset-0 bg-[url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNjAiIGhlaWdodD0iNjAiIHZpZXdCb3g9IjAgMCA2MCA2MCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPjxnIGZpbGw9IiNmZmYiIGZpbGwtb3BhY2l0eT0iMC4wMyI+PGNpcmNsZSBjeD0iMzAiIGN5PSIzMCIgcj0iMiIvPjwvZz48L2c+PC9zdmc+')] opacity-50"></div>
    </div>

    <div class="absolute top-20 right-0 w-96 h-96 bg-primary-500/20 rounded-full blur-3xl"></div>
    <div class="absolute bottom-0 left-0 w-96 h-96 bg-primary-600/20 rounded-full blur-3xl"></div>

    <div class="container-custom relative z-10 py-32">
      <div class="grid lg:grid-cols-2 gap-12 items-center">
        <div ref="contentRef" class="text-white space-y-8">
          <div class="inline-flex items-center px-4 py-2 bg-white/10 backdrop-blur-sm rounded-full border border-white/20">
            <span class="w-2 h-2 bg-primary-500 rounded-full animate-pulse mr-2"></span>
            <span class="text-sm font-medium">Trusted by 500+ Companies Worldwide</span>
          </div>

          <h1 class="text-4xl sm:text-5xl lg:text-6xl font-bold leading-tight">
            End-of-Line <br>
            <span class="text-primary-400">Packaging Automation</span> <br>
            Solutions
          </h1>

          <p class="text-xl text-secondary-300 max-w-xl">
            Your one-stop solution for innovative packaging automation. We design, deliver, and support world-class systems for medical devices, pharmaceuticals, gloves, and FMCG industries.
          </p>

          <div class="flex flex-col sm:flex-row gap-4">
            <UiButton variant="primary" size="lg" to="/contact">
              Get Started
              <svg class="w-5 h-5 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 8l4 4m0 0l-4 4m4-4H3" />
              </svg>
            </UiButton>
            <UiButton variant="outline" size="lg" class="border-white/30 text-white hover:bg-white hover:text-secondary-900" to="/projects">
              View Projects
            </UiButton>
          </div>

          <div class="flex items-center space-x-8 pt-8 border-t border-white/10">
            <div>
              <p class="text-3xl font-bold text-primary-400">500+</p>
              <p class="text-sm text-secondary-400">Projects Delivered</p>
            </div>
            <div>
              <p class="text-3xl font-bold text-primary-400">25+</p>
              <p class="text-sm text-secondary-400">Countries Served</p>
            </div>
            <div>
              <p class="text-3xl font-bold text-primary-400">15+</p>
              <p class="text-sm text-secondary-400">Years Experience</p>
            </div>
          </div>
        </div>

        <div ref="imageRef" class="hidden lg:block relative">
          <div class="relative">
            <div class="absolute inset-0 bg-gradient-to-tr from-primary-600 to-primary-400 rounded-3xl transform rotate-3"></div>
            <div class="relative bg-secondary-800 rounded-3xl p-8 transform -rotate-1 hover:rotate-0 transition-transform duration-500">
              <div class="aspect-video rounded-2xl overflow-hidden">
                <img
                  src="/hero-image.png"
                  alt="Packaging Automation Machinery"
                  class="w-full h-full object-cover"
                />
              </div>
              
              <div class="mt-6 grid grid-cols-3 gap-4">
                <div class="bg-secondary-700 rounded-lg p-3">
                  <div class="w-8 h-8 bg-primary-500/20 rounded-lg flex items-center justify-center mb-2">
                    <svg class="w-4 h-4 text-primary-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                  </div>
                  <p class="text-xs text-secondary-400">ISO Certified</p>
                </div>
                <div class="bg-secondary-700 rounded-lg p-3">
                  <div class="w-8 h-8 bg-primary-500/20 rounded-lg flex items-center justify-center mb-2">
                    <svg class="w-4 h-4 text-primary-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
                    </svg>
                  </div>
                  <p class="text-xs text-secondary-400">Fast Delivery</p>
                </div>
                <div class="bg-secondary-700 rounded-lg p-3">
                  <div class="w-8 h-8 bg-primary-500/20 rounded-lg flex items-center justify-center mb-2">
                    <svg class="w-4 h-4 text-primary-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18.364 5.636l-3.536 3.536m0 5.656l3.536 3.536M9.172 9.172L5.636 5.636m3.536 9.192l-3.536 3.536M21 12a9 9 0 11-18 0 9 9 0 0118 0zm-5 0a4 4 0 11-8 0 4 4 0 018 0z" />
                    </svg>
                  </div>
                  <p class="text-xs text-secondary-400">24/7 Support</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="absolute bottom-8 left-1/2 transform -translate-x-1/2 animate-bounce">
      <a href="#services" class="flex flex-col items-center text-white/60 hover:text-white transition-colors">
        <span class="text-sm mb-2">Scroll to explore</span>
        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 14l-7 7m0 0l-7-7m7 7V3" />
        </svg>
      </a>
    </div>
  </section>
</template>

<script setup lang="ts">
const { animate, staggerAnimation } = useAnimations()
const contentRef = ref<HTMLElement | null>(null)
const imageRef = ref<HTMLElement | null>(null)

onMounted(() => {
  if (contentRef.value) {
    animate(contentRef.value, {
      opacity: [0, 1],
      translateX: [-50, 0]
    }, { duration: 1000, easing: 'easeOutExpo' })
  }
  
  if (imageRef.value) {
    animate(imageRef.value, {
      opacity: [0, 1],
      translateX: [50, 0]
    }, { duration: 1000, delay: 300, easing: 'easeOutExpo' })
  }
})
</script>
