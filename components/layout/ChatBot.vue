<template>
  <div class="fixed bottom-6 right-6 z-50">
    <Transition
      enter-active-class="transition-all duration-300"
      enter-from-class="opacity-0 scale-95"
      enter-to-class="opacity-100 scale-100"
      leave-active-class="transition-all duration-200"
      leave-from-class="opacity-100 scale-100"
      leave-to-class="opacity-0 scale-95"
    >
      <div 
        v-if="isOpen"
        class="absolute bottom-16 right-0 w-80 sm:w-96 bg-white rounded-2xl shadow-2xl overflow-hidden border border-secondary-200"
      >
        <div class="bg-primary-600 text-white px-4 py-3 flex items-center justify-between">
          <div class="flex items-center space-x-3">
            <div class="w-10 h-10 bg-white/20 rounded-full flex items-center justify-center">
              <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z" />
              </svg>
            </div>
            <div>
              <h4 class="font-semibold">SpadeX Support</h4>
              <p class="text-xs text-white/80">We typically reply instantly</p>
            </div>
          </div>
          <button 
            @click="close"
            class="p-1 hover:bg-white/20 rounded-lg transition-colors"
          >
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
        </div>

        <div v-if="!session" class="p-4">
          <h5 class="font-medium text-secondary-900 mb-4">Start a conversation</h5>
          <form @submit.prevent="startChat" class="space-y-3">
            <input
              v-model="visitorForm.name"
              type="text"
              placeholder="Your name"
              class="w-full px-3 py-2 border border-secondary-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
              required
            >
            <input
              v-model="visitorForm.email"
              type="email"
              placeholder="Your email"
              class="w-full px-3 py-2 border border-secondary-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
              required
            >
            <UiButton type="submit" variant="primary" block :loading="isLoading">
              Start Chat
            </UiButton>
          </form>
        </div>

        <template v-else>
          <div 
            ref="messagesContainer"
            class="h-80 overflow-y-auto p-4 space-y-4 bg-secondary-50"
          >
            <div 
              v-for="message in messages" 
              :key="message.id"
              :class="[
                'max-w-[80%] px-3 py-2 rounded-lg text-sm',
                message.sender_type === 'visitor' 
                  ? 'ml-auto bg-primary-600 text-white rounded-br-none' 
                  : 'mr-auto bg-white shadow rounded-bl-none'
              ]"
            >
              {{ message.message }}
              <p class="text-xs mt-1 opacity-70">
                {{ formatTime(message.created_at) }}
              </p>
            </div>
            
            <div v-if="isTyping" class="flex items-center space-x-2 text-secondary-500">
              <div class="flex space-x-1">
                <div class="w-2 h-2 bg-secondary-400 rounded-full animate-bounce" style="animation-delay: 0ms"></div>
                <div class="w-2 h-2 bg-secondary-400 rounded-full animate-bounce" style="animation-delay: 150ms"></div>
                <div class="w-2 h-2 bg-secondary-400 rounded-full animate-bounce" style="animation-delay: 300ms"></div>
              </div>
              <span class="text-xs">Support is typing...</span>
            </div>
          </div>

          <form @submit.prevent="sendMessage" class="p-4 border-t border-secondary-200 bg-white">
            <div class="flex space-x-2">
              <input
                v-model="newMessage"
                type="text"
                placeholder="Type your message..."
                class="flex-1 px-3 py-2 border border-secondary-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
                :disabled="isLoading"
              >
              <UiButton 
                type="submit" 
                variant="primary" 
                :disabled="!newMessage.trim() || isLoading"
              >
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 19l9 2-9-18-9 18 9-2zm0 0v-8" />
                </svg>
              </UiButton>
            </div>
          </form>
        </template>
      </div>
    </Transition>

    <button
      @click="toggle"
      class="w-14 h-14 bg-primary-600 hover:bg-primary-700 text-white rounded-full shadow-lg flex items-center justify-center transition-all duration-300 hover:scale-110"
      :class="{ 'rotate-0': isOpen, 'rotate-12': !isOpen }"
    >
      <svg v-if="!isOpen" class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z" />
      </svg>
      <svg v-else class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
      </svg>
    </button>
  </div>
</template>

<script setup lang="ts">
const { 
  session, 
  messages, 
  isLoading, 
  isOpen, 
  isTyping,
  createSession, 
  sendMessage: sendChatMessage, 
  closeChat, 
  openChat 
} = useChat()

const newMessage = ref('')
const messagesContainer = ref<HTMLElement | null>(null)
const visitorForm = reactive({
  name: '',
  email: ''
})

const toggle = () => {
  if (isOpen.value) {
    closeChat()
  } else {
    openChat()
  }
}

const close = () => {
  closeChat()
}

const startChat = async () => {
  try {
    await createSession({
      name: visitorForm.name,
      email: visitorForm.email
    })
  } catch (error) {
    console.error('Failed to start chat:', error)
  }
}

const sendMessage = async () => {
  if (!newMessage.value.trim()) return
  
  const message = newMessage.value
  newMessage.value = ''
  
  try {
    await sendChatMessage(message)
    await nextTick()
    scrollToBottom()
  } catch (error) {
    console.error('Failed to send message:', error)
  }
}

const scrollToBottom = () => {
  if (messagesContainer.value) {
    messagesContainer.value.scrollTop = messagesContainer.value.scrollHeight
  }
}

const formatTime = (dateString: string) => {
  const date = new Date(dateString)
  return date.toLocaleTimeString('en-US', { 
    hour: 'numeric', 
    minute: '2-digit',
    hour12: true 
  })
}

watch(messages, () => {
  nextTick(scrollToBottom)
}, { deep: true })
</script>
