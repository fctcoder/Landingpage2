<template>
  <Teleport to="body">
    <Transition
      enter-active-class="transition-opacity duration-200"
      enter-from-class="opacity-0"
      enter-to-class="opacity-100"
      leave-active-class="transition-opacity duration-150"
      leave-from-class="opacity-100"
      leave-to-class="opacity-0"
    >
      <div 
        v-if="modelValue" 
        class="fixed inset-0 z-50 overflow-y-auto"
        @click.self="closeOnBackdrop && close()"
      >
        <div class="min-h-screen px-4 flex items-center justify-center">
          <div class="fixed inset-0 bg-black/50 backdrop-blur-sm" @click="closeOnBackdrop && close()" />
          
          <Transition
            enter-active-class="transition-all duration-300"
            enter-from-class="opacity-0 scale-95"
            enter-to-class="opacity-100 scale-100"
            leave-active-class="transition-all duration-200"
            leave-from-class="opacity-100 scale-100"
            leave-to-class="opacity-0 scale-95"
          >
            <div 
              v-if="modelValue"
              :class="modalClasses"
              role="dialog"
              aria-modal="true"
              :aria-labelledby="title ? 'modal-title' : undefined"
            >
              <div v-if="title || $slots.header" class="px-6 py-4 border-b border-secondary-200">
                <slot name="header">
                  <div class="flex items-center justify-between">
                    <h3 id="modal-title" class="text-lg font-semibold text-secondary-900">
                      {{ title }}
                    </h3>
                    <button 
                      v-if="showClose"
                      type="button"
                      class="p-1 text-secondary-400 hover:text-secondary-600 transition-colors rounded-lg hover:bg-secondary-100"
                      @click="close"
                    >
                      <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                      </svg>
                    </button>
                  </div>
                </slot>
              </div>
              
              <div :class="bodyClass">
                <slot />
              </div>
              
              <div v-if="$slots.footer" class="px-6 py-4 border-t border-secondary-200 bg-secondary-50 rounded-b-xl">
                <slot name="footer" />
              </div>
            </div>
          </Transition>
        </div>
      </div>
    </Transition>
  </Teleport>
</template>

<script setup lang="ts">
interface Props {
  modelValue: boolean
  title?: string
  size?: 'sm' | 'md' | 'lg' | 'xl' | 'full'
  showClose?: boolean
  closeOnBackdrop?: boolean
  closeOnEscape?: boolean
  bodyClass?: string
}

const props = withDefaults(defineProps<Props>(), {
  size: 'md',
  showClose: true,
  closeOnBackdrop: true,
  closeOnEscape: true,
  bodyClass: 'p-6'
})

const emit = defineEmits<{
  'update:modelValue': [value: boolean]
  close: []
}>()

const close = () => {
  emit('update:modelValue', false)
  emit('close')
}

const modalClasses = computed(() => {
  const base = 'relative bg-white rounded-xl shadow-xl w-full z-10 max-h-[90vh] overflow-y-auto'
  
  const sizes = {
    sm: 'max-w-sm',
    md: 'max-w-md',
    lg: 'max-w-lg',
    xl: 'max-w-xl',
    full: 'max-w-4xl'
  }
  
  return [base, sizes[props.size]]
})

onMounted(() => {
  if (props.closeOnEscape) {
    const handleEscape = (e: KeyboardEvent) => {
      if (e.key === 'Escape' && props.modelValue) {
        close()
      }
    }
    document.addEventListener('keydown', handleEscape)
    onUnmounted(() => {
      document.removeEventListener('keydown', handleEscape)
    })
  }
})

watch(() => props.modelValue, (value) => {
  if (value) {
    document.body.style.overflow = 'hidden'
  } else {
    document.body.style.overflow = ''
  }
})
</script>
