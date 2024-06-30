<template>
  <div class="chat-container">
    <div class="messages">
      <span v-for="(message, index) in messages" :key="index" class="message">{{ message }}</span>
    </div>
    <form @submit.prevent="sendMessage">
      <input v-model="newMessage" placeholder="Type your message" />
      <button type="submit">Send</button>
    </form>
  </div>
</template>

<script>
export default {
  data() {
    return {
      newMessage: '',
      messages: []
    };
  },
  methods: {
    async sendMessage() {
      const response = await fetch('/stream', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ message: this.newMessage }),
      });

      const reader = response.body.getReader();
      const decoder = new TextDecoder();
      let done = false;

      while (!done) {
        const { value, done: readerDone } = await reader.read();
        done = readerDone;
        if (value) {
          const chunk = decoder.decode(value, { stream: true });
          this.messages.push(chunk);
        }
      }

      this.newMessage = '';
    }
  }
}
</script>

<style scoped>
.chat-container {
  max-width: 600px;
  margin: 0 auto;
  padding: 1rem;
  border: 1px solid #ccc;
  border-radius: 8px;
}
.messages {
  max-height: 400px;
  overflow-y: auto;
  margin-bottom: 1rem;
  text-align: left;
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
</style>
