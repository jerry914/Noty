<template>
  <div class="chat-container">
    <form @submit.prevent="sendMessage">
      <input v-model="newMessage" placeholder="Type your message" @focus="setFocus" @blur="saveMessages" />
      <button type="submit" :class="isResponsing ? 'disable' : ''">
        <font-awesome-icon :icon="['fas', 'paper-plane']" /> Send
      </button>
    </form>
    <div class="messages">
      <span v-dompurify-html="this.messages.join('')"></span>
    </div>
    <StreamingComponent v-if="currentQuestion" :title="currentQuestion" @response-chunk="handleChunk" @response-complete="handleComplete" />
  </div>
</template>

<script>
import StreamingComponent from './StreamingComponent.vue';

export default {
  components: {
    StreamingComponent,
  },
  data() {
    return {
      newMessage: '',
      messages: [],
      currentQuestion: '',
      isResponsing: false,
      isFocus: false
    };
  },
  methods: {
    sendMessage() {
      if (this.isResponsing) return;
      this.currentQuestion = this.newMessage;
      this.isResponsing = true;
      this.messages.push(this.currentQuestion + '<br>');
      this.newMessage = '';
    },
    handleChunk(chunk) {
      this.messages.push(chunk);
    },
    handleComplete(content) {
      this.messages.push('<br>');
      this.isResponsing = false;
      this.currentQuestion = '';
      if (!this.isFocus) {
        this.saveMessages();
      }
    },
    setFocus() {
      this.isFocus = true;
    },
    async saveMessages() {
      this.isFocus = false;
      if (this.isResponsing) return;
      if (this.messages.length > 0) {
        const message = this.messages[0];
        try {
          const response = await fetch('/api/chat/summarize', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json'
            },
            body: JSON.stringify({ message })
          });
          
          if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
          }

          const data = await response.text();

          this.$emit('new-card', { title: data, content: this.messages.join('') });
          this.messages = [];
        } catch (error) {
          console.error('Error:', error);
        }
      }
    }
  },
};
</script>

<style scoped>
.chat-container {
  display: inline-block;
  width: 100%;
}
.messages {
  max-height: 400px;
  overflow-y: auto;
  margin-bottom: 1rem;
}

form {
  display: flex;
}
input {
  flex: 1;
  padding: 0.5rem;
  border: 1px solid #ccc;
  border-radius: 4px;
}
button {
  padding: 0.5rem 1rem;
  border: none;
  background-color: #007bff;
  color: white;
  border-radius: 4px;
  margin-left: 0.5rem;
}
button.disable {
  background-color: #585858;
}
</style>
