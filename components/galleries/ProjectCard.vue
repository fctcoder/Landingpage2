<template>
  <div class="group relative overflow-hidden rounded-xl bg-white shadow-lg hover:shadow-xl transition-all duration-300">
    <div class="aspect-[4/3] relative overflow-hidden">
      <img 
        v-if="project.images && project.images.length > 0"
        :src="project.images[0]" 
        :alt="project.title"
        class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500"
      >
      <div v-else class="w-full h-full bg-gradient-to-br from-secondary-100 to-secondary-200 flex items-center justify-center">
        <svg class="w-16 h-16 text-secondary-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
        </svg>
      </div>
      
      <div class="absolute inset-0 bg-gradient-to-t from-black/80 via-black/20 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300"></div>
      
      <div class="absolute bottom-0 left-0 right-0 p-4 transform translate-y-full group-hover:translate-y-0 transition-transform duration-300">
        <button 
          @click="openModal"
          class="w-full bg-primary-600 text-white py-2 px-4 rounded-lg hover:bg-primary-700 transition-colors text-sm font-medium"
        >
          View Details
        </button>
      </div>
      
      <div v-if="project.is_featured" class="absolute top-3 right-3">
        <span class="px-2 py-1 bg-primary-600 text-white text-xs font-medium rounded">
          Featured
        </span>
      </div>
    </div>
    
    <div class="p-5">
      <div class="flex items-center gap-2 mb-2">
        <span v-if="project.industry" class="px-2 py-1 bg-primary-100 text-primary-700 text-xs font-medium rounded">
          {{ project.industry }}
        </span>
        <span v-if="project.year" class="text-secondary-500 text-sm">
          {{ project.year }}
        </span>
      </div>
      
      <h3 class="text-lg font-semibold text-secondary-900 mb-2 line-clamp-1">
        {{ project.title }}
      </h3>
      
      <p v-if="project.description" class="text-secondary-600 text-sm line-clamp-2 mb-3">
        {{ project.description }}
      </p>
      
      <div v-if="project.client_name" class="flex items-center text-sm text-secondary-500">
        <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4" />
        </svg>
        {{ project.client_name }}
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import type { Project } from '~/types'

interface Props {
  project: Project
}

const props = defineProps<Props>()

const emit = defineEmits<{
  viewDetails: [project: Project]
}>()

const openModal = () => {
  emit('viewDetails', props.project)
}
</script>
