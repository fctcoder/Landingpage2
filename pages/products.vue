<template>
  <div>
    <section class="relative py-24 bg-gradient-to-br from-secondary-900 via-secondary-800 to-primary-900 overflow-hidden">
      <div class="absolute inset-0 bg-[url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNjAiIGhlaWdodD0iNjAiIHZpZXdCb3g9IjAgMCA2MCA2MCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPjxnIGZpbGw9IiNmZmYiIGZpbGwtb3BhY2l0eT0iMC4wMyI+PGNpcmNsZSBjeD0iMzAiIGN5PSIzMCIgcj0iMiIvPjwvZz48L2c+PC9zdmc+')] opacity-50"></div>
      <div class="container-custom relative z-10">
        <div class="max-w-3xl">
          <span class="inline-block px-4 py-1 bg-primary-500/20 text-primary-300 rounded-full text-sm font-medium mb-4">
            Our Products
          </span>
          <h1 class="text-4xl md:text-5xl lg:text-6xl font-bold text-white mb-6">
            Packaging <span class="text-primary-400">Products</span> Catalog
          </h1>
          <p class="text-xl text-secondary-300">
            Discover our range of high-quality packaging automation equipment designed for various industries.
          </p>
        </div>
      </div>
    </section>

    <section class="section-padding bg-white">
      <div class="container-custom">
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
          
          <div class="relative">
            <input 
              v-model="searchQuery"
              type="text"
              placeholder="Search products..."
              class="pl-10 pr-4 py-2 border border-secondary-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 w-64"
            >
            <svg class="absolute left-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-secondary-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
            </svg>
          </div>
        </div>

        <div v-if="filteredProducts.length > 0" class="grid md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
          <GalleriesProductCard 
            v-for="product in filteredProducts" 
            :key="product.id"
            :product="product"
            @view-details="openProductModal"
            @inquire="inquireProduct"
          />
        </div>

        <div v-else class="text-center py-16">
          <svg class="w-16 h-16 text-secondary-300 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
          </svg>
          <h3 class="text-lg font-medium text-secondary-900 mb-2">No products found</h3>
          <p class="text-secondary-600">Try adjusting your search or filters.</p>
        </div>
      </div>
    </section>

    <UiModal v-model="showModal" :title="selectedProduct?.name" size="xl">
      <div v-if="selectedProduct">
        <div class="grid md:grid-cols-2 gap-8">
          <div>
            <div class="aspect-square bg-secondary-100 rounded-xl overflow-hidden mb-4">
              <img 
                v-if="selectedProduct.images && selectedProduct.images.length > 0"
                :src="selectedProduct.images[0]" 
                :alt="selectedProduct.name"
                class="w-full h-full object-cover"
              >
              <div v-else class="w-full h-full flex items-center justify-center">
                <svg class="w-24 h-24 text-secondary-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
                </svg>
              </div>
            </div>
            
            <div v-if="selectedProduct.images && selectedProduct.images.length > 1" class="flex gap-2">
              <div 
                v-for="(img, idx) in selectedProduct.images.slice(0, 4)" 
                :key="idx"
                class="w-16 h-16 bg-secondary-100 rounded-lg overflow-hidden cursor-pointer hover:ring-2 hover:ring-primary-500"
              >
                <img :src="img" :alt="`${selectedProduct.name} ${idx + 1}`" class="w-full h-full object-cover">
              </div>
            </div>
          </div>
          
          <div>
            <div class="flex items-center gap-2 mb-2">
              <span v-if="selectedProduct.category" class="px-2 py-1 bg-primary-100 text-primary-700 text-xs font-medium rounded">
                {{ selectedProduct.category }}
              </span>
              <span v-if="selectedProduct.price_range" class="text-primary-600 font-semibold">
                {{ selectedProduct.price_range }}
              </span>
            </div>
            
            <h3 class="text-2xl font-bold text-secondary-900 mb-4">{{ selectedProduct.name }}</h3>
            
            <p class="text-secondary-600 mb-6">
              {{ selectedProduct.description || 'Contact us for detailed product information.' }}
            </p>
            
            <div v-if="selectedProduct.specs && Object.keys(selectedProduct.specs).length > 0" class="mb-6">
              <h4 class="font-semibold text-secondary-900 mb-3">Specifications</h4>
              <dl class="bg-secondary-50 rounded-lg divide-y divide-secondary-200">
                <div 
                  v-for="(value, key) in selectedProduct.specs" 
                  :key="key"
                  class="flex justify-between px-4 py-2"
                >
                  <dt class="text-secondary-600">{{ key }}</dt>
                  <dd class="text-secondary-900 font-medium">{{ value }}</dd>
                </div>
              </dl>
            </div>
            
            <div class="flex gap-3">
              <UiButton variant="primary" @click="inquireProduct(selectedProduct)">
                Request Quote
              </UiButton>
              <UiButton v-if="selectedProduct.brochure_url" variant="outline" :to="selectedProduct.brochure_url" external>
                Download Brochure
              </UiButton>
            </div>
          </div>
        </div>
      </div>
    </UiModal>

    <UiModal v-model="showInquiryModal" title="Product Inquiry" size="lg">
      <form @submit.prevent="submitInquiry" class="space-y-4">
        <div class="grid md:grid-cols-2 gap-4">
          <div>
            <label class="block text-sm font-medium text-secondary-700 mb-1">Name *</label>
            <input 
              v-model="inquiryForm.name"
              type="text"
              required
              class="w-full px-4 py-3 border border-secondary-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
            >
          </div>
          <div>
            <label class="block text-sm font-medium text-secondary-700 mb-1">Email *</label>
            <input 
              v-model="inquiryForm.email"
              type="email"
              required
              class="w-full px-4 py-3 border border-secondary-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
            >
          </div>
        </div>
        
        <div class="grid md:grid-cols-2 gap-4">
          <div>
            <label class="block text-sm font-medium text-secondary-700 mb-1">Phone</label>
            <input 
              v-model="inquiryForm.phone"
              type="tel"
              class="w-full px-4 py-3 border border-secondary-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
            >
          </div>
          <div>
            <label class="block text-sm font-medium text-secondary-700 mb-1">Company</label>
            <input 
              v-model="inquiryForm.company"
              type="text"
              class="w-full px-4 py-3 border border-secondary-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
            >
          </div>
        </div>
        
        <div>
          <label class="block text-sm font-medium text-secondary-700 mb-1">Quantity</label>
          <input 
            v-model="inquiryForm.quantity"
            type="text"
            placeholder="e.g., 1 unit, 5 units"
            class="w-full px-4 py-3 border border-secondary-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
          >
        </div>
        
        <div>
          <label class="block text-sm font-medium text-secondary-700 mb-1">Message</label>
          <textarea 
            v-model="inquiryForm.message"
            rows="4"
            class="w-full px-4 py-3 border border-secondary-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 resize-none"
            placeholder="Tell us about your requirements..."
          ></textarea>
        </div>
        
        <div class="flex justify-end gap-3">
          <UiButton type="button" variant="secondary" @click="showInquiryModal = false">
            Cancel
          </UiButton>
          <UiButton type="submit" variant="primary" :loading="isSubmitting">
            Submit Inquiry
          </UiButton>
        </div>
      </form>
    </UiModal>

    <section class="section-padding bg-primary-600">
      <div class="container-custom text-center">
        <h2 class="text-3xl font-bold text-white mb-6">Need a Custom Solution?</h2>
        <p class="text-primary-100 mb-8 max-w-2xl mx-auto">
          Our engineering team can design and build custom packaging solutions tailored to your specific requirements.
        </p>
        <UiButton variant="outline" size="lg" class="border-white text-white hover:bg-white hover:text-primary-600" to="/contact">
          Request Custom Solution
        </UiButton>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
import type { Product } from '~/types'

useHead({
  title: 'Products - SpadeX',
  meta: [
    { name: 'description', content: 'Explore our range of packaging automation products including case packers, cartoners, palletizers, and more.' }
  ]
})

const selectedCategory = ref('All')
const searchQuery = ref('')
const showModal = ref(false)
const showInquiryModal = ref(false)
const selectedProduct = ref<Product | null>(null)
const isSubmitting = ref(false)

const inquiryForm = reactive({
  name: '',
  email: '',
  phone: '',
  company: '',
  quantity: '',
  message: ''
})

const categories = ['All', 'Case Packers', 'Cartoners', 'Palletizers', 'Conveyors', 'Labeling', 'Inspection']

const products: Product[] = [
  {
    id: '1',
    name: 'SPX-CP200 Case Packer',
    description: 'High-speed automatic case packer designed for various product configurations with quick changeover capabilities.',
    specs: {
      'Speed': 'Up to 30 cases/min',
      'Case Size': '200x150x100 to 600x400x400 mm',
      'Power': '5.5 kW',
      'Air Pressure': '0.6 MPa'
    },
    images: ['/images/product-casepacker.jpg'],
    category: 'Case Packers',
    price_range: 'Contact for Price',
    is_featured: true,
    created_at: '2024-01-15'
  },
  {
    id: '2',
    name: 'SPX-CT150 Cartoner',
    description: 'Continuous motion cartoner for high-speed packaging of pharmaceutical and healthcare products.',
    specs: {
      'Speed': 'Up to 150 cartons/min',
      'Carton Size': 'Min 40x20x10 mm',
      'Power': '4 kW',
      'HMI': 'Touchscreen 10"'
    },
    images: ['/images/product-cartoner.jpg'],
    category: 'Cartoners',
    price_range: 'Contact for Price',
    is_featured: true,
    created_at: '2024-01-20'
  },
  {
    id: '3',
    name: 'SPX-PL100 Palletizer',
    description: 'Robotic palletizer with advanced pattern building capabilities for various package types.',
    specs: {
      'Capacity': 'Up to 1000 bags/hour',
      'Payload': 'Up to 50 kg',
      'Layers': 'Programmable',
      'Robot Type': '6-axis articulated'
    },
    images: ['/images/product-palletizer.jpg'],
    category: 'Palletizers',
    price_range: 'Contact for Price',
    created_at: '2024-02-01'
  },
  {
    id: '4',
    name: 'SPX-CV500 Conveyor System',
    description: 'Modular conveyor system for flexible production line configurations with smart control.',
    specs: {
      'Width': '100-600 mm',
      'Speed': 'Variable 5-30 m/min',
      'Material': 'Stainless Steel 304',
      'Control': 'PLC with HMI'
    },
    images: ['/images/product-conveyor.jpg'],
    category: 'Conveyors',
    price_range: 'Contact for Price',
    created_at: '2024-02-10'
  },
  {
    id: '5',
    name: 'SPX-LB200 Labeling Machine',
    description: 'Automatic labeling machine for wrap-around, front/back, and top/bottom labeling applications.',
    specs: {
      'Speed': 'Up to 200 labels/min',
      'Label Size': '15-200 mm width',
      'Accuracy': '±0.5 mm',
      'Label Type': 'Pressure sensitive'
    },
    images: ['/images/product-labeling.jpg'],
    category: 'Labeling',
    price_range: 'Contact for Price',
    created_at: '2024-02-15'
  },
  {
    id: '6',
    name: 'SPX-IN100 Vision Inspector',
    description: 'Advanced vision inspection system for quality control with AI-powered defect detection.',
    specs: {
      'Resolution': '5 MP',
      'Inspection Items': 'Print, Fill Level, Seal',
      'Speed': 'Up to 300 items/min',
      'AI': 'Deep Learning'
    },
    images: ['/images/product-inspection.jpg'],
    category: 'Inspection',
    price_range: 'Contact for Price',
    created_at: '2024-02-20'
  },
  {
    id: '7',
    name: 'SPX-CP100 Compact Case Packer',
    description: 'Compact automatic case packer ideal for limited space applications.',
    specs: {
      'Speed': 'Up to 15 cases/min',
      'Case Size': '200x150x100 to 400x300x300 mm',
      'Power': '3 kW',
      'Footprint': '2.5 x 2.0 m'
    },
    images: ['/images/product-casepacker.jpg'],
    category: 'Case Packers',
    price_range: 'Contact for Price',
    created_at: '2024-03-01'
  },
  {
    id: '8',
    name: 'SPX-CT80 Intermittent Cartoner',
    description: 'Intermittent motion cartoner for versatile packaging needs with easy format changes.',
    specs: {
      'Speed': 'Up to 80 cartons/min',
      'Carton Size': 'Min 60x30x15 mm',
      'Power': '3.5 kW',
      'Changeover': 'Under 15 min'
    },
    images: ['/images/product-cartoner.jpg'],
    category: 'Cartoners',
    price_range: 'Contact for Price',
    created_at: '2024-03-05'
  }
]

const filteredProducts = computed(() => {
  let filtered = products
  
  if (selectedCategory.value && selectedCategory.value !== 'All') {
    filtered = filtered.filter(p => p.category === selectedCategory.value)
  }
  
  if (searchQuery.value) {
    const query = searchQuery.value.toLowerCase()
    filtered = filtered.filter(p => 
      p.name.toLowerCase().includes(query) ||
      p.description?.toLowerCase().includes(query) ||
      p.category?.toLowerCase().includes(query)
    )
  }
  
  return filtered
})

const openProductModal = (product: Product) => {
  selectedProduct.value = product
  showModal.value = true
}

const inquireProduct = (product: Product) => {
  selectedProduct.value = product
  inquiryForm.message = `I am interested in the ${product.name}. Please provide more information.`
  showInquiryModal.value = true
  showModal.value = false
}

const submitInquiry = async () => {
  isSubmitting.value = true
  try {
    console.log('Submitting inquiry:', inquiryForm)
    showInquiryModal.value = false
    Object.assign(inquiryForm, {
      name: '',
      email: '',
      phone: '',
      company: '',
      quantity: '',
      message: ''
    })
  } catch (error) {
    console.error('Failed to submit inquiry:', error)
  } finally {
    isSubmitting.value = false
  }
}
</script>
