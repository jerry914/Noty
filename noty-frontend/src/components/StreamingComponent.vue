<template>
</template>

<script>
export default {
  name: 'StreamingComponent',
  props: {
    question: {
      type: String,
      required: true,
    },
  },
  data() {
    return {
      isResponsing: false,
    };
  },
  watch: {
    question: {
      immediate: true,
      handler(newQuestion) {
        if (newQuestion) {
          this.sendMessage(newQuestion);
        }
      },
    },
  },
  methods: {
    async sendMessage(question) {
      if (this.isResponsing) return;
      this.isResponsing = true;

      const response = await fetch('/api/chat/stream', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ message: question }),
      });

      const reader = response.body.getReader();
      const decoder = new TextDecoder();
      let done = false;
      let answer = '';

      while (!done) {
        const { value, done: readerDone } = await reader.read();
        done = readerDone;
        if (value) {
          const chunk = decoder.decode(value, { stream: true });
          answer += chunk;
          this.$emit('response-chunk', chunk); // Emit each chunk
        }
      }

      this.isResponsing = false;
      this.$emit('response-complete', answer); // Emit the complete answer
    },
  },
};
</script>
