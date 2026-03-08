<template>
  <div>
    <section class="relative py-24 bg-gradient-to-br from-secondary-900 via-secondary-800 to-primary-900 overflow-hidden">
      <div class="absolute inset-0 bg-[url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNjAiIGhlaWdodD0iNjAiIHZpZXdCb3g9IjAgMCA2MCA2MCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPjxnIGZpbGw9IiNmZmYiIGZpbGwtb3BhY2l0eT0iMC4wMyI+PGNpcmNsZSBjeD0iMzAiIGN5PSIzMCIgcj0iMiIvPjwvZz48L2c+PC9zdmc+')] opacity-50"></div>
      <div class="container-custom relative z-10">
        <div class="max-w-3xl">
          <h1 class="text-4xl md:text-5xl font-bold text-white mb-4">Privacy Policy</h1>
          <p class="text-xl text-secondary-300">Your privacy is important to us.</p>
        </div>
      </div>
    </section>

    <section class="section-padding bg-white">
      <div class="container-custom">
        <div class="max-w-4xl prose prose-lg">
          <p class="text-secondary-600 mb-6">Last updated: March 2026</p>
          
          <h2 class="text-2xl font-bold text-secondary-900 mb-4">Information We Collect</h2>
          <p class="text-secondary-600 mb-6">
            We collect information you provide directly to us, including when you fill out a contact form, 
            subscribe to our newsletter, or otherwise communicate with us.
          </p>

          <h2 class="text-2xl font-bold text-secondary-900 mb-4">How We Use Information</h2>
          <p class="text-secondary-600 mb-6">
            We use the information we collect to provide, maintain, and improve our services, 
            to communicate with you, and to comply with legal obligations.
          </p>

          <h2 class="text-2xl font-bold text-secondary-900 mb-4">Contact Us</h2>
          <p class="text-secondary-600 mb-6">
            If you have any questions about this Privacy Policy, please contact us at 
            <a href="mailto:info@spadex.com" class="text-primary-600 hover:underline">info@spadex.com</a>
          </p>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
useHead({
  title: 'Privacy Policy - SpadeX'
})
</script>
