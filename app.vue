<template>
  <div class="min-h-screen flex flex-col">
    <LayoutHeader />
    <main class="flex-1">
      <NuxtPage />
    </main>
    <LayoutFooter />
    <LayoutChatBot />
  </div>
</template>

<script setup lang="ts">
useHead({
  htmlAttrs: {
    lang: 'en'
  }
})
</script>

<style>
.page-enter-active,
.page-leave-active {
  transition: all 0.3s;
}
.page-enter-from,
.page-leave-to {
  opacity: 0;
  filter: blur(1px);
}
</style>
