<template>
  <div>
    <section class="relative py-24 bg-gradient-to-br from-secondary-900 via-secondary-800 to-primary-900 overflow-hidden">
      <div class="absolute inset-0 bg-[url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNjAiIGhlaWdodD0iNjAiIHZpZXdCb3g9IjAgMCA2MCA2MCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPjxnIGZpbGw9IiNmZmYiIGZpbGwtb3BhY2l0eT0iMC4wMyI+PGNpcmNsZSBjeD0iMzAiIGN5PSIzMCIgcj0iMiIvPjwvZz48L2c+PC9zdmc+')] opacity-50"></div>
      <div class="container-custom relative z-10">
        <div class="max-w-3xl">
          <span class="inline-block px-4 py-1 bg-primary-500/20 text-primary-300 rounded-full text-sm font-medium mb-4">
            Our Projects
          </span>
          <h1 class="text-4xl md:text-5xl lg:text-6xl font-bold text-white mb-6">
            Successful <span class="text-primary-400">Projects</span> Gallery
          </h1>
          <p class="text-xl text-secondary-300">
            Explore our portfolio of successful packaging automation projects across various industries.
          </p>
        </div>
      </div>
    </section>

    <section class="section-padding bg-white">
      <div class="container-custom">
        <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4 mb-8">
          <div class="flex flex-wrap gap-2">
            <button 
              v-for="ind in industries" 
              :key="ind"
              @click="selectedIndustry = ind"
              class="px-4 py-2 rounded-lg text-sm font-medium transition-colors"
              :class="selectedIndustry === ind ? 'bg-primary-600 text-white' : 'bg-secondary-100 text-secondary-600 hover:bg-secondary-200'"
            >
              {{ ind }}
            </button>
          </div>
          
          <div class="flex items-center gap-4">
            <select 
              v-model="selectedYear"
              class="px-4 py-2 border border-secondary-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
            >
              <option value="">All Years</option>
              <option v-for="year in years" :key="year" :value="year">{{ year }}</option>
            </select>
          </div>
        </div>

        <div v-if="filteredProjects.length > 0" class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
          <GalleriesProjectCard 
            v-for="project in filteredProjects" 
            :key="project.id"
            :project="project"
            @view-details="openProjectModal"
          />
        </div>

        <div v-else class="text-center py-16">
          <svg class="w-16 h-16 text-secondary-300 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10" />
          </svg>
          <h3 class="text-lg font-medium text-secondary-900 mb-2">No projects found</h3>
          <p class="text-secondary-600">Try adjusting your filters to see more results.</p>
        </div>
      </div>
    </section>

    <UiModal v-model="showModal" :title="selectedProject?.title" size="xl">
      <div v-if="selectedProject">
        <div class="aspect-video bg-secondary-100 rounded-xl mb-6 overflow-hidden">
          <img 
            v-if="selectedProject.images && selectedProject.images.length > 0"
            :src="selectedProject.images[0]" 
            :alt="selectedProject.title"
            class="w-full h-full object-cover"
          >
        </div>
        
        <div class="grid md:grid-cols-2 gap-6">
          <div>
            <h4 class="font-semibold text-secondary-900 mb-2">Project Details</h4>
            <dl class="space-y-2">
              <div v-if="selectedProject.industry" class="flex justify-between">
                <dt class="text-secondary-500">Industry:</dt>
                <dd class="text-secondary-900 font-medium">{{ selectedProject.industry }}</dd>
              </div>
              <div v-if="selectedProject.year" class="flex justify-between">
                <dt class="text-secondary-500">Year:</dt>
                <dd class="text-secondary-900 font-medium">{{ selectedProject.year }}</dd>
              </div>
              <div v-if="selectedProject.client_name" class="flex justify-between">
                <dt class="text-secondary-500">Client:</dt>
                <dd class="text-secondary-900 font-medium">{{ selectedProject.client_name }}</dd>
              </div>
              <div v-if="selectedProject.project_type" class="flex justify-between">
                <dt class="text-secondary-500">Type:</dt>
                <dd class="text-secondary-900 font-medium">{{ selectedProject.project_type }}</dd>
              </div>
              <div v-if="selectedProject.location" class="flex justify-between">
                <dt class="text-secondary-500">Location:</dt>
                <dd class="text-secondary-900 font-medium">{{ selectedProject.location }}</dd>
              </div>
            </dl>
          </div>
          
          <div>
            <h4 class="font-semibold text-secondary-900 mb-2">Description</h4>
            <p class="text-secondary-600">
              {{ selectedProject.description || 'No description available.' }}
            </p>
          </div>
        </div>
        
        <div class="mt-6 pt-6 border-t border-secondary-200">
          <UiButton variant="primary" to="/contact">
            Request Similar Project
          </UiButton>
        </div>
      </div>
    </UiModal>

    <section class="section-padding bg-primary-600">
      <div class="container-custom text-center">
        <h2 class="text-3xl font-bold text-white mb-6">Have a Project in Mind?</h2>
        <p class="text-primary-100 mb-8 max-w-2xl mx-auto">
          Let's discuss how we can help bring your packaging automation vision to life.
        </p>
        <UiButton variant="outline" size="lg" class="border-white text-white hover:bg-white hover:text-primary-600" to="/contact">
          Start Your Project
        </UiButton>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
import type { Project } from '~/types'

useHead({
  title: 'Projects - SpadeX',
  meta: [
    { name: 'description', content: 'Explore our portfolio of successful packaging automation projects across medical devices, pharmaceuticals, gloves, and FMCG industries.' }
  ]
})

const selectedIndustry = ref('')
const selectedYear = ref<number | ''>('')
const showModal = ref(false)
const selectedProject = ref<Project | null>(null)

const industries = ['All Industries', 'Medical Devices', 'Pharmaceuticals', 'Gloves', 'FMCG']
const years = [2024, 2023, 2022, 2021, 2020]

const projects: Project[] = [
  {
    id: '1',
    title: 'Medical Device Packaging Line',
    description: 'Complete end-of-line packaging system for surgical instruments with sterile packaging capabilities.',
    images: ['/images/project-medical.jpg'],
    industry: 'Medical Devices',
    year: 2024,
    client_name: 'MedTech Solutions',
    project_type: 'Turnkey',
    location: 'Singapore',
    is_featured: true,
    created_at: '2024-01-15'
  },
  {
    id: '2',
    title: 'Pharmaceutical Cartoning System',
    description: 'High-speed cartoning system for pharmaceutical products with serialization and track-and-trace capabilities.',
    images: ['/images/project-pharma.jpg'],
    industry: 'Pharmaceuticals',
    year: 2024,
    client_name: 'PharmaCorp',
    project_type: 'Custom',
    location: 'Malaysia',
    is_featured: true,
    created_at: '2024-02-01'
  },
  {
    id: '3',
    title: 'Glove Packaging Automation',
    description: 'Automated counting and packaging system for medical and industrial gloves with multi-pack options.',
    images: ['/images/project-gloves.jpg'],
    industry: 'Gloves',
    year: 2023,
    client_name: 'GloveMaster Sdn Bhd',
    project_type: 'Turnkey',
    location: 'Malaysia',
    created_at: '2023-08-20'
  },
  {
    id: '4',
    title: 'FMCG Case Packing System',
    description: 'Flexible case packing system for consumer goods with quick changeover capabilities.',
    images: ['/images/project-fmcg.jpg'],
    industry: 'FMCG',
    year: 2023,
    client_name: 'Global FMCG Ltd',
    project_type: 'Custom',
    location: 'Vietnam',
    created_at: '2023-11-10'
  },
  {
    id: '5',
    title: 'Syringe Packaging Line',
    description: 'Complete packaging line for medical syringes with tamper-evident sealing.',
    images: ['/images/project-syringe.jpg'],
    industry: 'Medical Devices',
    year: 2023,
    client_name: 'Healthcare Products Inc',
    project_type: 'Turnkey',
    location: 'Indonesia',
    created_at: '2023-06-15'
  },
  {
    id: '6',
    title: 'Tablet Blister Packaging',
    description: 'High-speed blister packaging system for pharmaceutical tablets with quality inspection.',
    images: ['/images/project-tablet.jpg'],
    industry: 'Pharmaceuticals',
    year: 2022,
    client_name: 'MediPharm',
    project_type: 'Custom',
    location: 'Thailand',
    created_at: '2022-09-20'
  }
]

const filteredProjects = computed(() => {
  let filtered = projects
  
  if (selectedIndustry.value && selectedIndustry.value !== 'All Industries') {
    filtered = filtered.filter(p => p.industry === selectedIndustry.value)
  }
  
  if (selectedYear.value) {
    filtered = filtered.filter(p => p.year === selectedYear.value)
  }
  
  return filtered
})

const openProjectModal = (project: Project) => {
  selectedProject.value = project
  showModal.value = true
}
</script>
