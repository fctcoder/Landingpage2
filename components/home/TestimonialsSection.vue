<template>
  <section class="section-padding bg-white overflow-hidden">
    <div class="container-custom">
      <div class="text-center mb-16">
        <span class="inline-block px-4 py-1 bg-primary-100 text-primary-700 rounded-full text-sm font-medium mb-4">
          Testimonials
        </span>
        <h2 class="section-title">What Our Clients Say</h2>
        <p class="section-subtitle">
          Trusted by leading companies across the globe for reliable packaging automation solutions.
        </p>
      </div>

      <div class="relative">
        <div class="absolute left-0 top-1/2 -translate-y-1/2 z-10 hidden lg:block">
          <button 
            @click="prevSlide"
            class="w-12 h-12 bg-white rounded-full shadow-lg flex items-center justify-center hover:bg-primary-50 transition-colors"
          >
            <svg class="w-6 h-6 text-secondary-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
            </svg>
          </button>
        </div>
        
        <div class="absolute right-0 top-1/2 -translate-y-1/2 z-10 hidden lg:block">
          <button 
            @click="nextSlide"
            class="w-12 h-12 bg-white rounded-full shadow-lg flex items-center justify-center hover:bg-primary-50 transition-colors"
          >
            <svg class="w-6 h-6 text-secondary-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
            </svg>
          </button>
        </div>

        <div class="overflow-hidden px-4 lg:px-12">
          <div 
            class="flex transition-transform duration-500 ease-out"
            :style="{ transform: `translateX(-${currentSlide * 100}%)` }"
          >
            <div 
              v-for="(testimonial, index) in testimonials" 
              :key="testimonial.id"
              class="w-full md:w-1/2 lg:w-1/3 flex-shrink-0 px-4"
            >
              <div class="bg-secondary-50 rounded-2xl p-8 h-full">
                <div class="flex items-center mb-4">
                  <div class="flex text-yellow-400">
                    <svg v-for="i in 5" :key="i" class="w-5 h-5" :class="i <= testimonial.rating ? 'text-yellow-400' : 'text-secondary-300'" fill="currentColor" viewBox="0 0 20 20">
                      <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                    </svg>
                  </div>
                </div>
                
                <blockquote class="text-secondary-700 mb-6 italic">
                  "{{ testimonial.quote }}"
                </blockquote>
                
                <div class="flex items-center">
                  <div class="w-12 h-12 bg-primary-100 rounded-full flex items-center justify-center mr-4">
                    <span class="text-primary-600 font-semibold text-lg">
                      {{ testimonial.name.charAt(0) }}
                    </span>
                  </div>
                  <div>
                    <p class="font-semibold text-secondary-900">{{ testimonial.name }}</p>
                    <p class="text-sm text-secondary-500">{{ testimonial.position }}, {{ testimonial.company }}</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="flex justify-center mt-8 space-x-2">
          <button 
            v-for="(_, index) in totalSlides" 
            :key="index"
            @click="goToSlide(index)"
            class="w-2 h-2 rounded-full transition-all duration-300"
            :class="currentSlide === index ? 'bg-primary-600 w-6' : 'bg-secondary-300'"
          />
        </div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
const currentSlide = ref(0)
const slidesPerView = computed(() => {
  if (process.client) {
    if (window.innerWidth >= 1024) return 3
    if (window.innerWidth >= 768) return 2
  }
  return 1
})

const testimonials = [
  {
    id: '1',
    name: 'Sarah Chen',
    position: 'Operations Director',
    company: 'MedTech Solutions',
    quote: 'SpadeX transformed our packaging line efficiency by 40%. Their team understood our medical device requirements perfectly and delivered a solution that exceeded our expectations.',
    rating: 5
  },
  {
    id: '2',
    name: 'Michael Thompson',
    position: 'Plant Manager',
    company: 'PharmaCorp',
    quote: 'The pharmaceutical packaging system they installed has been running flawlessly for 3 years. Their support team is responsive and the spare parts availability is excellent.',
    rating: 5
  },
  {
    id: '3',
    name: 'Ahmad Razak',
    position: 'CEO',
    company: 'GloveMaster Sdn Bhd',
    quote: 'We chose SpadeX for our glove packaging needs and it was the best decision. The high-speed counting and packaging system increased our output significantly.',
    rating: 5
  },
  {
    id: '4',
    name: 'Jennifer Lee',
    position: 'Quality Manager',
    company: 'Global FMCG Ltd',
    quote: 'The flexibility of their packaging systems allows us to handle multiple product formats with minimal changeover time. A game-changer for our operations.',
    rating: 4
  },
  {
    id: '5',
    name: 'David Kim',
    position: 'Supply Chain Director',
    company: 'Asia Medical Devices',
    quote: 'From design to installation, the SpadeX team was professional and knowledgeable. The project was completed on time and within budget.',
    rating: 5
  },
  {
    id: '6',
    name: 'Lisa Wong',
    position: 'Production Manager',
    company: 'Healthcare Products Inc',
    quote: 'The training provided was comprehensive and our operators were up to speed quickly. The documentation is thorough and well-organized.',
    rating: 5
  }
]

const totalSlides = computed(() => Math.ceil(testimonials.length / slidesPerView.value))

const nextSlide = () => {
  currentSlide.value = (currentSlide.value + 1) % totalSlides.value
}

const prevSlide = () => {
  currentSlide.value = currentSlide.value === 0 ? totalSlides.value - 1 : currentSlide.value - 1
}

const goToSlide = (index: number) => {
  currentSlide.value = index
}

let autoPlayInterval: ReturnType<typeof setInterval>

onMounted(() => {
  autoPlayInterval = setInterval(nextSlide, 5000)
})

onUnmounted(() => {
  clearInterval(autoPlayInterval)
})
</script>
