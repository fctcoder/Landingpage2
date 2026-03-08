<template>
  <div :class="cardClasses">
    <div v-if="$slots.image || image" class="relative overflow-hidden">
      <slot name="image">
        <img 
          v-if="image" 
          :src="image" 
          :alt="imageAlt" 
          class="w-full h-48 object-cover"
          :class="imageClass"
        >
      </slot>
      <div v-if="badge" class="absolute top-3 left-3">
        <span class="px-2 py-1 text-xs font-medium bg-primary-600 text-white rounded">
          {{ badge }}
        </span>
      </div>
    </div>
    
    <div :class="bodyClass">
      <slot />
    </div>
    
    <div v-if="$slots.footer" :class="footerClass">
      <slot name="footer" />
    </div>
  </div>
</template>

<script setup lang="ts">
interface Props {
  variant?: 'default' | 'bordered' | 'elevated'
  hover?: boolean
  image?: string
  imageAlt?: string
  imageClass?: string
  badge?: string
  bodyClass?: string
  footerClass?: string
}

const props = withDefaults(defineProps<Props>(), {
  variant: 'default',
  hover: false,
  bodyClass: 'p-5',
  footerClass: 'px-5 py-4 bg-secondary-50 border-t border-secondary-100'
})

const cardClasses = computed(() => {
  const base = 'overflow-hidden rounded-xl'
  
  const variants = {
    default: 'bg-white shadow-lg',
    bordered: 'bg-white border border-secondary-200',
    elevated: 'bg-white shadow-xl'
  }
  
  const hoverClass = props.hover ? 'transition-all duration-300 hover:shadow-xl hover:-translate-y-1' : ''
  
  return [base, variants[props.variant], hoverClass]
})
</script>
