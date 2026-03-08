<template>
  <div class="group relative overflow-hidden rounded-xl bg-white shadow-lg hover:shadow-xl transition-all duration-300">
    <div class="aspect-square relative overflow-hidden">
      <img 
        v-if="product.images && product.images.length > 0"
        :src="product.images[0]" 
        :alt="product.name"
        class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500"
      >
      <div v-else class="w-full h-full bg-gradient-to-br from-secondary-100 to-secondary-200 flex items-center justify-center">
        <svg class="w-20 h-20 text-secondary-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
        </svg>
      </div>
      
      <div class="absolute inset-0 bg-gradient-to-t from-black/80 via-black/20 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300"></div>
      
      <div class="absolute bottom-0 left-0 right-0 p-4 transform translate-y-full group-hover:translate-y-0 transition-transform duration-300 flex gap-2">
        <button 
          @click="openModal"
          class="flex-1 bg-primary-600 text-white py-2 px-4 rounded-lg hover:bg-primary-700 transition-colors text-sm font-medium"
        >
          View Details
        </button>
        <button 
          @click="inquireProduct"
          class="bg-white text-secondary-900 py-2 px-4 rounded-lg hover:bg-secondary-100 transition-colors text-sm font-medium"
        >
          Inquire
        </button>
      </div>
      
      <div v-if="product.is_featured" class="absolute top-3 right-3">
        <span class="px-2 py-1 bg-primary-600 text-white text-xs font-medium rounded">
          Featured
        </span>
      </div>
    </div>
    
    <div class="p-5">
      <div class="flex items-center gap-2 mb-2">
        <span v-if="product.category" class="px-2 py-1 bg-secondary-100 text-secondary-700 text-xs font-medium rounded">
          {{ product.category }}
        </span>
        <span v-if="product.price_range" class="text-primary-600 text-sm font-medium">
          {{ product.price_range }}
        </span>
      </div>
      
      <h3 class="text-lg font-semibold text-secondary-900 mb-2 line-clamp-1">
        {{ product.name }}
      </h3>
      
      <p v-if="product.description" class="text-secondary-600 text-sm line-clamp-2 mb-3">
        {{ product.description }}
      </p>
      
      <div v-if="product.specs && Object.keys(product.specs).length > 0" class="flex flex-wrap gap-2">
        <span 
          v-for="(value, key) in getSpecsPreview(product.specs)" 
          :key="key"
          class="text-xs text-secondary-500 bg-secondary-50 px-2 py-1 rounded"
        >
          {{ key }}: {{ value }}
        </span>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import type { Product } from '~/types'

interface Props {
  product: Product
}

const props = defineProps<Props>()

const emit = defineEmits<{
  viewDetails: [product: Product]
  inquire: [product: Product]
}>()

const openModal = () => {
  emit('viewDetails', props.product)
}

const inquireProduct = () => {
  emit('inquire', props.product)
}

const getSpecsPreview = (specs: Record<string, unknown>) => {
  const entries = Object.entries(specs).slice(0, 3)
  return Object.fromEntries(entries)
}
</script>
