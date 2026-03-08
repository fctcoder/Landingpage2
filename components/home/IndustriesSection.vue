<template>
  <section class="section-padding bg-secondary-50">
    <div class="container-custom">
      <div class="text-center mb-16">
        <span class="inline-block px-4 py-1 bg-primary-100 text-primary-700 rounded-full text-sm font-medium mb-4">
          Industries We Serve
        </span>
        <h2 class="section-title">Trusted Across Multiple Industries</h2>
        <p class="section-subtitle">
          Our packaging automation solutions are designed to meet the unique requirements of various high-demand industries.
        </p>
      </div>

      <div class="grid md:grid-cols-2 lg:grid-cols-4 gap-6">
        <div 
          v-for="(industry, index) in industries" 
          :key="industry.id"
          class="group relative overflow-hidden rounded-2xl bg-white shadow-lg hover:shadow-xl transition-all duration-300"
        >
          <div class="aspect-[4/5] relative overflow-hidden">
            <div 
              class="absolute inset-0 bg-gradient-to-br transition-transform duration-500 group-hover:scale-110"
              :class="industry.bgClass"
            ></div>
            
            <div class="absolute inset-0 bg-gradient-to-t from-black/80 via-black/40 to-transparent"></div>
            
            <div class="absolute inset-0 p-6 flex flex-col justify-end">
              <div class="w-12 h-12 bg-white/10 backdrop-blur-sm rounded-xl flex items-center justify-center mb-4 group-hover:bg-primary-500 transition-colors duration-300">
                <component :is="industry.icon" class="w-6 h-6 text-white" />
              </div>
              
              <h3 class="text-xl font-bold text-white mb-2">
                {{ industry.name }}
              </h3>
              
              <p class="text-white/80 text-sm mb-4 opacity-0 group-hover:opacity-100 transition-opacity duration-300">
                {{ industry.description }}
              </p>
              
              <ul class="space-y-1 text-xs text-white/70 opacity-0 group-hover:opacity-100 transition-opacity duration-300 delay-100">
                <li v-for="feature in industry.features" :key="feature" class="flex items-center">
                  <svg class="w-3 h-3 text-primary-400 mr-2" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd" />
                  </svg>
                  {{ feature }}
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>

      <div class="mt-12 text-center">
        <p class="text-secondary-600 mb-4">
          Don't see your industry? We also provide custom solutions for other sectors.
        </p>
        <UiButton variant="outline" to="/contact">
          Contact Us for Custom Solutions
        </UiButton>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import { h } from 'vue'

const MedicalIcon = {
  render: () => h('svg', { fill: 'none', stroke: 'currentColor', viewBox: '0 0 24 24', class: 'w-6 h-6' }, [
    h('path', { 'stroke-linecap': 'round', 'stroke-linejoin': 'round', 'stroke-width': '2', d: 'M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z' })
  ])
}

const PharmacyIcon = {
  render: () => h('svg', { fill: 'none', stroke: 'currentColor', viewBox: '0 0 24 24', class: 'w-6 h-6' }, [
    h('path', { 'stroke-linecap': 'round', 'stroke-linejoin': 'round', 'stroke-width': '2', d: 'M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10' })
  ])
}

const GlovesIcon = {
  render: () => h('svg', { fill: 'none', stroke: 'currentColor', viewBox: '0 0 24 24', class: 'w-6 h-6' }, [
    h('path', { 'stroke-linecap': 'round', 'stroke-linejoin': 'round', 'stroke-width': '2', d: 'M7 11.5V14m0-2.5v-6a1.5 1.5 0 113 0m-3 6a1.5 1.5 0 00-3 0v2a7.5 7.5 0 0015 0v-5a1.5 1.5 0 00-3 0m-6-3V11m0-5.5v-1a1.5 1.5 0 013 0v1m0 0V11m0-5.5a1.5 1.5 0 013 0v3m0 0V11' })
  ])
}

const FMCGIcon = {
  render: () => h('svg', { fill: 'none', stroke: 'currentColor', viewBox: '0 0 24 24', class: 'w-6 h-6' }, [
    h('path', { 'stroke-linecap': 'round', 'stroke-linejoin': 'round', 'stroke-width': '2', d: 'M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4' })
  ])
}

const industries = [
  {
    id: 'medical',
    name: 'Medical Devices',
    description: 'Precision packaging for surgical instruments, diagnostic equipment, and medical components.',
    features: ['Cleanroom compatible', 'Sterile packaging', 'Traceability systems'],
    icon: MedicalIcon,
    bgClass: 'from-blue-600 to-blue-800'
  },
  {
    id: 'pharmacy',
    name: 'Pharmaceuticals',
    description: 'Compliant packaging solutions for tablets, capsules, and pharmaceutical products.',
    features: ['GMP compliant', 'Child-resistant', 'Tamper evident'],
    icon: PharmacyIcon,
    bgClass: 'from-emerald-600 to-emerald-800'
  },
  {
    id: 'gloves',
    name: 'Gloves',
    description: 'High-speed packaging lines for medical and industrial glove manufacturers.',
    features: ['High-speed counting', 'Multi-pack options', 'Quality inspection'],
    icon: GlovesIcon,
    bgClass: 'from-purple-600 to-purple-800'
  },
  {
    id: 'fmcg',
    name: 'FMCG',
    description: 'Flexible packaging systems for food, beverages, and consumer goods.',
    features: ['High throughput', 'Flexible formats', 'Eco-friendly options'],
    icon: FMCGIcon,
    bgClass: 'from-orange-600 to-orange-800'
  }
]
</script>
