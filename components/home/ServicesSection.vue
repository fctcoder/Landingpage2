<template>
  <section id="services" class="section-padding bg-white">
    <div class="container-custom">
      <div class="text-center mb-16">
        <span class="inline-block px-4 py-1 bg-primary-100 text-primary-700 rounded-full text-sm font-medium mb-4">
          Our Services
        </span>
        <h2 class="section-title">One-Stop Solution for All Your Needs</h2>
        <p class="section-subtitle">
          From design to delivery, we provide comprehensive packaging automation services tailored to your industry requirements.
        </p>
      </div>

      <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
        <div 
          v-for="(service, index) in services" 
          :key="service.title"
          ref="serviceCards"
          class="group bg-white rounded-2xl p-8 border border-secondary-100 hover:border-primary-200 hover:shadow-xl transition-all duration-300"
        >
          <div class="w-14 h-14 bg-primary-100 rounded-xl flex items-center justify-center mb-6 group-hover:bg-primary-600 transition-colors duration-300">
            <component :is="service.icon" class="w-7 h-7 text-primary-600 group-hover:text-white transition-colors duration-300" />
          </div>
          
          <h3 class="text-xl font-semibold text-secondary-900 mb-3">
            {{ service.title }}
          </h3>
          
          <p class="text-secondary-600 mb-4">
            {{ service.description }}
          </p>
          
          <ul class="space-y-2">
            <li v-for="feature in service.features" :key="feature" class="flex items-center text-sm text-secondary-600">
              <svg class="w-4 h-4 text-primary-500 mr-2 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
              </svg>
              {{ feature }}
            </li>
          </ul>
        </div>
      </div>

      <div class="mt-16 text-center">
        <UiButton variant="primary" size="lg" to="/contact">
          Discuss Your Requirements
          <svg class="w-5 h-5 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 8l4 4m0 0l-4 4m4-4H3" />
          </svg>
        </UiButton>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import { h } from 'vue'

const { animateOnScroll } = useAnimations()
const serviceCards = ref<HTMLElement[]>([])

onMounted(() => {
  animateOnScroll('.group', 'fadeInUp', { stagger: 100 })
})

const DesignIcon = {
  render: () => h('svg', { fill: 'none', stroke: 'currentColor', viewBox: '0 0 24 24', class: 'w-7 h-7' }, [
    h('path', { 'stroke-linecap': 'round', 'stroke-linejoin': 'round', 'stroke-width': '2', d: 'M9 17V7m0 10a2 2 0 01-2 2H5a2 2 0 01-2-2V7a2 2 0 012-2h2a2 2 0 012 2m0 10a2 2 0 002 2h2a2 2 0 002-2M9 7a2 2 0 012-2h2a2 2 0 012 2m0 10V7m0 10a2 2 0 002 2h2a2 2 0 002-2V7a2 2 0 00-2-2h-2a2 2 0 00-2 2' })
  ])
}

const BuildIcon = {
  render: () => h('svg', { fill: 'none', stroke: 'currentColor', viewBox: '0 0 24 24', class: 'w-7 h-7' }, [
    h('path', { 'stroke-linecap': 'round', 'stroke-linejoin': 'round', 'stroke-width': '2', d: 'M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z' }),
    h('path', { 'stroke-linecap': 'round', 'stroke-linejoin': 'round', 'stroke-width': '2', d: 'M15 12a3 3 0 11-6 0 3 3 0 016 0z' })
  ])
}

const DeliveryIcon = {
  render: () => h('svg', { fill: 'none', stroke: 'currentColor', viewBox: '0 0 24 24', class: 'w-7 h-7' }, [
    h('path', { 'stroke-linecap': 'round', 'stroke-linejoin': 'round', 'stroke-width': '2', d: 'M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4' })
  ])
}

const InstallIcon = {
  render: () => h('svg', { fill: 'none', stroke: 'currentColor', viewBox: '0 0 24 24', class: 'w-7 h-7' }, [
    h('path', { 'stroke-linecap': 'round', 'stroke-linejoin': 'round', 'stroke-width': '2', d: 'M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10' })
  ])
}

const SupportIcon = {
  render: () => h('svg', { fill: 'none', stroke: 'currentColor', viewBox: '0 0 24 24', class: 'w-7 h-7' }, [
    h('path', { 'stroke-linecap': 'round', 'stroke-linejoin': 'round', 'stroke-width': '2', d: 'M18.364 5.636l-3.536 3.536m0 5.656l3.536 3.536M9.172 9.172L5.636 5.636m3.536 9.192l-3.536 3.536M21 12a9 9 0 11-18 0 9 9 0 0118 0zm-5 0a4 4 0 11-8 0 4 4 0 018 0z' })
  ])
}

const TrainingIcon = {
  render: () => h('svg', { fill: 'none', stroke: 'currentColor', viewBox: '0 0 24 24', class: 'w-7 h-7' }, [
    h('path', { 'stroke-linecap': 'round', 'stroke-linejoin': 'round', 'stroke-width': '2', d: 'M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253' })
  ])
}

const services = [
  {
    title: 'Custom Design',
    description: 'Tailored packaging solutions designed to meet your specific requirements and industry standards.',
    features: ['3D CAD modeling', 'Prototype development', 'Compliance design'],
    icon: DesignIcon
  },
  {
    title: 'Manufacturing',
    description: 'State-of-the-art manufacturing facilities ensuring quality and precision in every component.',
    features: ['CNC machining', 'Quality assurance', 'ISO certification'],
    icon: BuildIcon
  },
  {
    title: 'Global Delivery',
    description: 'Reliable worldwide shipping and logistics to deliver your equipment anywhere in the world.',
    features: ['Export documentation', 'Insurance coverage', 'Tracking system'],
    icon: DeliveryIcon
  },
  {
    title: 'Installation',
    description: 'Professional installation and commissioning by our experienced technical team.',
    features: ['Site preparation', 'Equipment setup', 'Performance testing'],
    icon: InstallIcon
  },
  {
    title: '24/7 Support',
    description: 'Round-the-clock technical support and maintenance services for optimal performance.',
    features: ['Remote diagnostics', 'Spare parts supply', 'Emergency response'],
    icon: SupportIcon
  },
  {
    title: 'Training',
    description: 'Comprehensive training programs for your team to maximize system efficiency.',
    features: ['Operator training', 'Maintenance training', 'Documentation'],
    icon: TrainingIcon
  }
]
</script>
