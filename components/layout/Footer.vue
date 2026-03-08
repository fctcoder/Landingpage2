<template>
  <footer class="bg-secondary-900 text-white">
    <div class="container-custom py-16">
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-12">
        <div>
          <NuxtLink to="/" class="flex items-center space-x-2 mb-6">
            <svg class="w-10 h-10 text-primary-500" viewBox="0 0 40 40" fill="currentColor">
              <path d="M20 4L4 12v16l16 8 16-8V12L20 4zm0 2.5L32.5 13 20 19.5 7.5 13 20 6.5zM6 14.5l13 6.5v13l-13-6.5v-13zm28 0v13l-13 6.5v-13l13-6.5z"/>
            </svg>
            <span class="text-2xl font-bold">Spade<span class="text-primary-500">X</span></span>
          </NuxtLink>
          <p class="text-secondary-400 mb-6">
            Leading end-of-line packaging automation solutions provider based in Malaysia, serving global markets with innovative and reliable solutions.
          </p>
          <div class="flex space-x-4">
            <a 
              v-for="social in socialLinks" 
              :key="social.name"
              :href="social.url" 
              target="_blank"
              rel="noopener noreferrer"
              class="p-2 bg-secondary-800 rounded-lg hover:bg-primary-600 transition-colors"
              :aria-label="social.name"
            >
              <component :is="social.icon" class="w-5 h-5" />
            </a>
          </div>
        </div>

        <div>
          <h4 class="text-lg font-semibold mb-6">Quick Links</h4>
          <ul class="space-y-3">
            <li v-for="item in quickLinks" :key="item.path">
              <NuxtLink 
                :to="item.path" 
                class="text-secondary-400 hover:text-primary-500 transition-colors"
              >
                {{ item.name }}
              </NuxtLink>
            </li>
          </ul>
        </div>

        <div>
          <h4 class="text-lg font-semibold mb-6">Solutions</h4>
          <ul class="space-y-3">
            <li v-for="solution in solutions" :key="solution">
              <NuxtLink 
                to="/products" 
                class="text-secondary-400 hover:text-primary-500 transition-colors"
              >
                {{ solution }}
              </NuxtLink>
            </li>
          </ul>
        </div>

        <div>
          <h4 class="text-lg font-semibold mb-6">Contact Us</h4>
          <ul class="space-y-4">
            <li class="flex items-start space-x-3">
              <svg class="w-5 h-5 text-primary-500 mt-0.5 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
              </svg>
              <span class="text-secondary-400">
                No. 123, Jalan Industri 4.0,<br>
                47000 Sungai Buloh,<br>
                Selangor, Malaysia
              </span>
            </li>
            <li class="flex items-center space-x-3">
              <svg class="w-5 h-5 text-primary-500 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" />
              </svg>
              <a href="tel:+60361565888" class="text-secondary-400 hover:text-primary-500 transition-colors">
                +60 3-6156 5888
              </a>
            </li>
            <li class="flex items-center space-x-3">
              <svg class="w-5 h-5 text-primary-500 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
              </svg>
              <a href="mailto:info@spadex.com" class="text-secondary-400 hover:text-primary-500 transition-colors">
                info@spadex.com
              </a>
            </li>
          </ul>
        </div>
      </div>

      <div class="mt-12 pt-8 border-t border-secondary-800">
        <div class="flex flex-col md:flex-row justify-between items-center space-y-4 md:space-y-0">
          <p class="text-secondary-400 text-sm">
            © {{ currentYear }} SpadeX. All rights reserved.
          </p>
          <div class="flex space-x-6 text-sm">
            <NuxtLink to="/privacy" class="text-secondary-400 hover:text-primary-500 transition-colors">
              Privacy Policy
            </NuxtLink>
            <NuxtLink to="/terms" class="text-secondary-400 hover:text-primary-500 transition-colors">
              Terms of Service
            </NuxtLink>
          </div>
        </div>
      </div>
    </div>
  </footer>
</template>

<script setup lang="ts">
import { h } from 'vue'

const currentYear = new Date().getFullYear()

const quickLinks = [
  { name: 'About Us', path: '/about' },
  { name: 'Projects', path: '/projects' },
  { name: 'Products', path: '/products' },
  { name: 'Newsletter', path: '/newsletter' },
  { name: 'Investors', path: '/investors' },
  { name: 'Contact', path: '/contact' }
]

const solutions = [
  'Medical Device Packaging',
  'Pharmaceutical Packaging',
  'Glove Packaging',
  'FMCG Packaging',
  'Custom Solutions'
]

const LinkedinIcon = {
  render: () => h('svg', { fill: 'currentColor', viewBox: '0 0 24 24', class: 'w-5 h-5' }, [
    h('path', { d: 'M19 0h-14c-2.761 0-5 2.239-5 5v14c0 2.761 2.239 5 5 5h14c2.762 0 5-2.239 5-5v-14c0-2.761-2.238-5-5-5zm-11 19h-3v-11h3v11zm-1.5-12.268c-.966 0-1.75-.79-1.75-1.764s.784-1.764 1.75-1.764 1.75.79 1.75 1.764-.783 1.764-1.75 1.764zm13.5 12.268h-3v-5.604c0-3.368-4-3.113-4 0v5.604h-3v-11h3v1.765c1.396-2.586 7-2.777 7 2.476v6.759z' })
  ])
}

const TwitterIcon = {
  render: () => h('svg', { fill: 'currentColor', viewBox: '0 0 24 24', class: 'w-5 h-5' }, [
    h('path', { d: 'M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z' })
  ])
}

const FacebookIcon = {
  render: () => h('svg', { fill: 'currentColor', viewBox: '0 0 24 24', class: 'w-5 h-5' }, [
    h('path', { d: 'M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z' })
  ])
}

const YoutubeIcon = {
  render: () => h('svg', { fill: 'currentColor', viewBox: '0 0 24 24', class: 'w-5 h-5' }, [
    h('path', { d: 'M23.498 6.186a3.016 3.016 0 0 0-2.122-2.136C19.505 3.545 12 3.545 12 3.545s-7.505 0-9.377.505A3.017 3.017 0 0 0 .502 6.186C0 8.07 0 12 0 12s0 3.93.502 5.814a3.016 3.016 0 0 0 2.122 2.136c1.871.505 9.376.505 9.376.505s7.505 0 9.377-.505a3.015 3.015 0 0 0 2.122-2.136C24 15.93 24 12 24 12s0-3.93-.502-5.814zM9.545 15.568V8.432L15.818 12l-6.273 3.568z' })
  ])
}

const socialLinks = [
  { name: 'LinkedIn', url: 'https://linkedin.com/company/spadex', icon: LinkedinIcon },
  { name: 'Twitter', url: 'https://twitter.com/spadex', icon: TwitterIcon },
  { name: 'Facebook', url: 'https://facebook.com/spadex', icon: FacebookIcon },
  { name: 'YouTube', url: 'https://youtube.com/spadex', icon: YoutubeIcon }
]
</script>
