<template>
  <div>
    <section class="relative py-24 bg-gradient-to-br from-secondary-900 via-secondary-800 to-primary-900 overflow-hidden">
      <div class="absolute inset-0 bg-[url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNjAiIGhlaWdodD0iNjAiIHZpZXdCb3g9IjAgMCA2MCA2MCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPjxnIGZpbGw9IiNmZmYiIGZpbGwtb3BhY2l0eT0iMC4wMyI+PGNpcmNsZSBjeD0iMzAiIGN5PSIzMCIgcj0iMiIvPjwvZz48L2c+PC9zdmc+')] opacity-50"></div>
      <div class="container-custom relative z-10">
        <div class="max-w-3xl">
          <span class="inline-block px-4 py-1 bg-primary-500/20 text-primary-300 rounded-full text-sm font-medium mb-4">
            Contact Us
          </span>
          <h1 class="text-4xl md:text-5xl lg:text-6xl font-bold text-white mb-6">
            Get in <span class="text-primary-400">Touch</span>
          </h1>
          <p class="text-xl text-secondary-300">
            Have questions? We'd love to hear from you. Send us a message and we'll respond as soon as possible.
          </p>
        </div>
      </div>
    </section>

    <section class="section-padding bg-white">
      <div class="container-custom">
        <div class="grid lg:grid-cols-3 gap-12">
          <div class="lg:col-span-2">
            <div class="bg-white rounded-2xl shadow-xl p-8">
              <h2 class="text-2xl font-bold text-secondary-900 mb-6">Send us a Message</h2>
              
              <form @submit.prevent="submitForm" class="space-y-6">
                <div class="grid md:grid-cols-2 gap-6">
                  <div>
                    <label for="name" class="block text-sm font-medium text-secondary-700 mb-2">Full Name *</label>
                    <input 
                      id="name"
                      v-model="form.name"
                      type="text"
                      required
                      class="w-full px-4 py-3 border border-secondary-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 transition-colors"
                      placeholder="John Doe"
                    >
                  </div>
                  <div>
                    <label for="email" class="block text-sm font-medium text-secondary-700 mb-2">Email Address *</label>
                    <input 
                      id="email"
                      v-model="form.email"
                      type="email"
                      required
                      class="w-full px-4 py-3 border border-secondary-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 transition-colors"
                      placeholder="john@example.com"
                    >
                  </div>
                </div>

                <div class="grid md:grid-cols-2 gap-6">
                  <div>
                    <label for="phone" class="block text-sm font-medium text-secondary-700 mb-2">Phone Number</label>
                    <input 
                      id="phone"
                      v-model="form.phone"
                      type="tel"
                      class="w-full px-4 py-3 border border-secondary-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 transition-colors"
                      placeholder="+60 12-345 6789"
                    >
                  </div>
                  <div>
                    <label for="company" class="block text-sm font-medium text-secondary-700 mb-2">Company Name</label>
                    <input 
                      id="company"
                      v-model="form.company"
                      type="text"
                      class="w-full px-4 py-3 border border-secondary-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 transition-colors"
                      placeholder="Your Company"
                    >
                  </div>
                </div>

                <div class="grid md:grid-cols-2 gap-6">
                  <div>
                    <label for="industry" class="block text-sm font-medium text-secondary-700 mb-2">Industry</label>
                    <select 
                      id="industry"
                      v-model="form.industry"
                      class="w-full px-4 py-3 border border-secondary-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 transition-colors"
                    >
                      <option value="">Select Industry</option>
                      <option value="medical">Medical Devices</option>
                      <option value="pharmaceutical">Pharmaceuticals</option>
                      <option value="gloves">Gloves</option>
                      <option value="fmcg">FMCG</option>
                      <option value="other">Other</option>
                    </select>
                  </div>
                  <div>
                    <label for="country" class="block text-sm font-medium text-secondary-700 mb-2">Country</label>
                    <input 
                      id="country"
                      v-model="form.country"
                      type="text"
                      class="w-full px-4 py-3 border border-secondary-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 transition-colors"
                      placeholder="Malaysia"
                    >
                  </div>
                </div>

                <div>
                  <label for="subject" class="block text-sm font-medium text-secondary-700 mb-2">Subject</label>
                  <input 
                    id="subject"
                    v-model="form.subject"
                    type="text"
                    class="w-full px-4 py-3 border border-secondary-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 transition-colors"
                    placeholder="How can we help you?"
                  >
                </div>

                <div>
                  <label for="message" class="block text-sm font-medium text-secondary-700 mb-2">Message *</label>
                  <textarea 
                    id="message"
                    v-model="form.message"
                    rows="5"
                    required
                    class="w-full px-4 py-3 border border-secondary-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 transition-colors resize-none"
                    placeholder="Tell us about your project or inquiry..."
                  ></textarea>
                </div>

                <div class="flex items-center gap-3">
                  <input 
                    id="newsletter"
                    v-model="form.subscribe_newsletter"
                    type="checkbox"
                    class="w-4 h-4 text-primary-600 border-secondary-300 rounded focus:ring-primary-500"
                  >
                  <label for="newsletter" class="text-sm text-secondary-600">
                    Subscribe to our newsletter for updates and insights
                  </label>
                </div>

                <UiButton 
                  type="submit" 
                  variant="primary" 
                  size="lg" 
                  :loading="isSubmitting"
                  :disabled="isSubmitting"
                >
                  Send Message
                  <svg v-if="!isSubmitting" class="w-5 h-5 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 19l9 2-9-18-9 18 9-2zm0 0v-8" />
                  </svg>
                </UiButton>
              </form>

              <div v-if="formStatus" class="mt-6 p-4 rounded-lg" :class="formStatus.type === 'success' ? 'bg-primary-50 text-primary-700' : 'bg-red-50 text-red-700'">
                {{ formStatus.message }}
              </div>
            </div>
          </div>

          <div class="space-y-8">
            <div class="bg-secondary-50 rounded-2xl p-6">
              <h3 class="text-lg font-semibold text-secondary-900 mb-4">Contact Information</h3>
              
              <div class="space-y-4">
                <div class="flex items-start gap-3">
                  <div class="w-10 h-10 bg-primary-100 rounded-lg flex items-center justify-center flex-shrink-0">
                    <svg class="w-5 h-5 text-primary-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
                    </svg>
                  </div>
                  <div>
                    <h4 class="font-medium text-secondary-900">Headquarters</h4>
                    <p class="text-secondary-600 text-sm">
                      No. 123, Jalan Industri 4.0,<br>
                      47000 Sungai Buloh,<br>
                      Selangor, Malaysia
                    </p>
                  </div>
                </div>

                <div class="flex items-start gap-3">
                  <div class="w-10 h-10 bg-primary-100 rounded-lg flex items-center justify-center flex-shrink-0">
                    <svg class="w-5 h-5 text-primary-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" />
                    </svg>
                  </div>
                  <div>
                    <h4 class="font-medium text-secondary-900">Phone</h4>
                    <p class="text-secondary-600 text-sm">+60 3-6156 5888</p>
                    <p class="text-secondary-500 text-xs">Mon - Fri, 8am - 6pm (MYT)</p>
                  </div>
                </div>

                <div class="flex items-start gap-3">
                  <div class="w-10 h-10 bg-primary-100 rounded-lg flex items-center justify-center flex-shrink-0">
                    <svg class="w-5 h-5 text-primary-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                    </svg>
                  </div>
                  <div>
                    <h4 class="font-medium text-secondary-900">Email</h4>
                    <p class="text-secondary-600 text-sm">info@spadex.com</p>
                    <p class="text-secondary-500 text-xs">We reply within 24 hours</p>
                  </div>
                </div>
              </div>
            </div>

            <div class="bg-secondary-50 rounded-2xl p-6">
              <h3 class="text-lg font-semibold text-secondary-900 mb-4">Office Hours</h3>
              <ul class="space-y-2 text-sm">
                <li class="flex justify-between">
                  <span class="text-secondary-600">Monday - Friday</span>
                  <span class="text-secondary-900 font-medium">8:00 AM - 6:00 PM</span>
                </li>
                <li class="flex justify-between">
                  <span class="text-secondary-600">Saturday</span>
                  <span class="text-secondary-900 font-medium">9:00 AM - 1:00 PM</span>
                </li>
                <li class="flex justify-between">
                  <span class="text-secondary-600">Sunday</span>
                  <span class="text-red-600 font-medium">Closed</span>
                </li>
              </ul>
            </div>

            <div class="bg-secondary-50 rounded-2xl p-6">
              <h3 class="text-lg font-semibold text-secondary-900 mb-4">Follow Us</h3>
              <div class="flex gap-3">
                <a href="#" class="w-10 h-10 bg-white rounded-lg flex items-center justify-center hover:bg-primary-100 transition-colors">
                  <svg class="w-5 h-5 text-secondary-600" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M19 0h-14c-2.761 0-5 2.239-5 5v14c0 2.761 2.239 5 5 5h14c2.762 0 5-2.239 5-5v-14c0-2.761-2.238-5-5-5zm-11 19h-3v-11h3v11zm-1.5-12.268c-.966 0-1.75-.79-1.75-1.764s.784-1.764 1.75-1.764 1.75.79 1.75 1.764-.783 1.764-1.75 1.764zm13.5 12.268h-3v-5.604c0-3.368-4-3.113-4 0v5.604h-3v-11h3v1.765c1.396-2.586 7-2.777 7 2.476v6.759z"/>
                  </svg>
                </a>
                <a href="#" class="w-10 h-10 bg-white rounded-lg flex items-center justify-center hover:bg-primary-100 transition-colors">
                  <svg class="w-5 h-5 text-secondary-600" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"/>
                  </svg>
                </a>
                <a href="#" class="w-10 h-10 bg-white rounded-lg flex items-center justify-center hover:bg-primary-100 transition-colors">
                  <svg class="w-5 h-5 text-secondary-600" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M24 4.557c-.883.392-1.832.656-2.828.775 1.017-.609 1.798-1.574 2.165-2.724-.951.564-2.005.974-3.127 1.195-.897-.957-2.178-1.555-3.594-1.555-3.179 0-5.515 2.966-4.797 6.045-4.091-.205-7.719-2.165-10.148-5.144-1.29 2.213-.669 5.108 1.523 6.574-.806-.026-1.566-.247-2.229-.616-.054 2.281 1.581 4.415 3.949 4.89-.693.188-1.452.232-2.224.084.626 1.956 2.444 3.379 4.6 3.419-2.07 1.623-4.678 2.348-7.29 2.04 2.179 1.397 4.768 2.212 7.548 2.212 9.142 0 14.307-7.721 13.995-14.646.962-.695 1.797-1.562 2.457-2.549z"/>
                  </svg>
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="section-padding bg-secondary-50">
      <div class="container-custom">
        <div class="text-center mb-8">
          <h2 class="section-title">Our Location</h2>
          <p class="section-subtitle">Visit our headquarters in Sungai Buloh, Selangor.</p>
        </div>
        
        <div class="aspect-video bg-secondary-200 rounded-2xl overflow-hidden">
          <iframe 
            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3983.7462588867896!2d101.5874!3d3.2006!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x0!2zM8KwMTInMTguMiJOIDEwMcKwMzUnMTQuNiJF!5e0!3m2!1sen!2smy!4v1234567890"
            class="w-full h-full border-0"
            allowfullscreen
            loading="lazy"
            referrerpolicy="no-referrer-when-downgrade"
          ></iframe>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
useHead({
  title: 'Contact Us - SpadeX',
  meta: [
    { name: 'description', content: 'Contact SpadeX for packaging automation solutions. Get in touch with our team for inquiries, quotes, and support.' }
  ]
})

const form = reactive({
  name: '',
  email: '',
  phone: '',
  company: '',
  industry: '',
  country: '',
  subject: '',
  message: '',
  subscribe_newsletter: false
})

const isSubmitting = ref(false)
const formStatus = ref<{ type: 'success' | 'error'; message: string } | null>(null)

const submitForm = async () => {
  isSubmitting.value = true
  formStatus.value = null
  
  try {
    const response = await $fetch('/api/contact', {
      method: 'POST',
      body: form
    })
    
    if (response.success) {
      formStatus.value = {
        type: 'success',
        message: 'Thank you for your message! We will get back to you within 24 hours.'
      }
      
      Object.assign(form, {
        name: '',
        email: '',
        phone: '',
        company: '',
        industry: '',
        country: '',
        subject: '',
        message: '',
        subscribe_newsletter: false
      })
    } else {
      throw new Error(response.error)
    }
  } catch (error) {
    formStatus.value = {
      type: 'error',
      message: 'Failed to send message. Please try again or contact us directly.'
    }
  } finally {
    isSubmitting.value = false
  }
}
</script>
