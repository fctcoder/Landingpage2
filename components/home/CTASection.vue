<template>
  <section class="section-padding bg-gradient-to-br from-primary-600 via-primary-700 to-primary-800 relative overflow-hidden">
    <div class="absolute inset-0 bg-[url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNjAiIGhlaWdodD0iNjAiIHZpZXdCb3g9IjAgMCA2MCA2MCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPjxnIGZpbGw9IiNmZmYiIGZpbGwtb3BhY2l0eT0iMC4wNSI+PGNpcmNsZSBjeD0iMzAiIGN5PSIzMCIgcj0iMiIvPjwvZz48L2c+PC9zdmc+')] opacity-50"></div>
    
    <div class="absolute top-0 right-0 w-96 h-96 bg-white/10 rounded-full blur-3xl -translate-y-1/2 translate-x-1/2"></div>
    <div class="absolute bottom-0 left-0 w-96 h-96 bg-white/10 rounded-full blur-3xl translate-y-1/2 -translate-x-1/2"></div>

    <div class="container-custom relative z-10">
      <div class="grid lg:grid-cols-2 gap-12 items-center">
        <div class="text-white">
          <h2 class="text-3xl md:text-4xl lg:text-5xl font-bold mb-6">
            Ready to Transform Your Packaging Operations?
          </h2>
          <p class="text-lg text-white/90 mb-8">
            Get a customized solution designed for your specific needs. Our team of experts is ready to help you achieve operational excellence.
          </p>
          
          <div class="grid sm:grid-cols-2 gap-6 mb-8">
            <div class="flex items-start space-x-3">
              <div class="w-10 h-10 bg-white/20 rounded-lg flex items-center justify-center flex-shrink-0">
                <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                </svg>
              </div>
              <div>
                <h4 class="font-semibold">Free Consultation</h4>
                <p class="text-sm text-white/80">No-obligation assessment</p>
              </div>
            </div>
            
            <div class="flex items-start space-x-3">
              <div class="w-10 h-10 bg-white/20 rounded-lg flex items-center justify-center flex-shrink-0">
                <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
              </div>
              <div>
                <h4 class="font-semibold">Quick Response</h4>
                <p class="text-sm text-white/80">Response within 24 hours</p>
              </div>
            </div>
            
            <div class="flex items-start space-x-3">
              <div class="w-10 h-10 bg-white/20 rounded-lg flex items-center justify-center flex-shrink-0">
                <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
                </svg>
              </div>
              <div>
                <h4 class="font-semibold">Warranty Included</h4>
                <p class="text-sm text-white/80">Comprehensive coverage</p>
              </div>
            </div>
            
            <div class="flex items-start space-x-3">
              <div class="w-10 h-10 bg-white/20 rounded-lg flex items-center justify-center flex-shrink-0">
                <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                </svg>
              </div>
              <div>
                <h4 class="font-semibold">Expert Team</h4>
                <p class="text-sm text-white/80">Experienced engineers</p>
              </div>
            </div>
          </div>
        </div>

        <div class="bg-white rounded-2xl p-8 shadow-2xl">
          <h3 class="text-2xl font-bold text-secondary-900 mb-6">Get a Free Quote</h3>
          
          <form @submit.prevent="submitForm" class="space-y-4">
            <div class="grid sm:grid-cols-2 gap-4">
              <div>
                <label for="name" class="block text-sm font-medium text-secondary-700 mb-1">Name *</label>
                <input 
                  id="name"
                  v-model="form.name"
                  type="text"
                  required
                  class="w-full px-4 py-3 border border-secondary-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 transition-colors"
                  placeholder="Your name"
                >
              </div>
              <div>
                <label for="email" class="block text-sm font-medium text-secondary-700 mb-1">Email *</label>
                <input 
                  id="email"
                  v-model="form.email"
                  type="email"
                  required
                  class="w-full px-4 py-3 border border-secondary-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 transition-colors"
                  placeholder="your@email.com"
                >
              </div>
            </div>
            
            <div class="grid sm:grid-cols-2 gap-4">
              <div>
                <label for="phone" class="block text-sm font-medium text-secondary-700 mb-1">Phone</label>
                <input 
                  id="phone"
                  v-model="form.phone"
                  type="tel"
                  class="w-full px-4 py-3 border border-secondary-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 transition-colors"
                  placeholder="+60 12-345 6789"
                >
              </div>
              <div>
                <label for="industry" class="block text-sm font-medium text-secondary-700 mb-1">Industry</label>
                <select 
                  id="industry"
                  v-model="form.industry"
                  class="w-full px-4 py-3 border border-secondary-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 transition-colors"
                >
                  <option value="">Select industry</option>
                  <option value="medical">Medical Devices</option>
                  <option value="pharmaceutical">Pharmaceuticals</option>
                  <option value="gloves">Gloves</option>
                  <option value="fmcg">FMCG</option>
                  <option value="other">Other</option>
                </select>
              </div>
            </div>
            
            <div>
              <label for="message" class="block text-sm font-medium text-secondary-700 mb-1">Message *</label>
              <textarea 
                id="message"
                v-model="form.message"
                rows="4"
                required
                class="w-full px-4 py-3 border border-secondary-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 transition-colors resize-none"
                placeholder="Tell us about your packaging requirements..."
              ></textarea>
            </div>
            
            <UiButton 
              type="submit" 
              variant="primary" 
              size="lg" 
              block 
              :loading="isSubmitting"
            >
              Submit Request
              <svg v-if="!isSubmitting" class="w-5 h-5 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 8l4 4m0 0l-4 4m4-4H3" />
              </svg>
            </UiButton>
          </form>
          
          <p class="text-xs text-secondary-500 mt-4 text-center">
            By submitting, you agree to our <NuxtLink to="/privacy" class="text-primary-600 hover:underline">Privacy Policy</NuxtLink>
          </p>
        </div>
      </div>
    </div>
    
    <UiModal v-model="showSuccess" title="Request Submitted!">
      <div class="text-center py-4">
        <div class="w-16 h-16 bg-primary-100 rounded-full flex items-center justify-center mx-auto mb-4">
          <svg class="w-8 h-8 text-primary-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
          </svg>
        </div>
        <h4 class="text-lg font-semibold text-secondary-900 mb-2">Thank you for your inquiry!</h4>
        <p class="text-secondary-600">We'll get back to you within 24 hours.</p>
      </div>
    </UiModal>
  </section>
</template>

<script setup lang="ts">
const { submitContact } = useSupabase()

const form = reactive({
  name: '',
  email: '',
  phone: '',
  company: '',
  industry: '',
  message: ''
})

const isSubmitting = ref(false)
const showSuccess = ref(false)

const submitForm = async () => {
  isSubmitting.value = true
  try {
    await submitContact(form)
    showSuccess.value = true
    Object.assign(form, {
      name: '',
      email: '',
      phone: '',
      company: '',
      industry: '',
      message: ''
    })
  } catch (error) {
    console.error('Failed to submit form:', error)
  } finally {
    isSubmitting.value = false
  }
}
</script>
