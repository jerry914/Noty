<template>
</template>

<script>
export default {
  name: 'StreamingComponent',
  props: {
    title: {
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
    title: {
      immediate: true,
      handler(newTitle) {
        if (newTitle) {
          this.sendMessage(newTitle);
        }
      },
    },
  },
  methods: {
    async sendMessage(title) {
      if (this.isResponsing) return;
      this.isResponsing = true;

      const response = await fetch('/api/chat/stream', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ message: title }),
      });

      const reader = response.body.getReader();
      const decoder = new TextDecoder();
      let done = false;
      let content = '';

      while (!done) {
        const { value, done: readerDone } = await reader.read();
        done = readerDone;
        if (value) {
          const chunk = decoder.decode(value, { stream: true });
          content += chunk;
          this.$emit('response-chunk', chunk); // Emit each chunk
        }
      }

      this.isResponsing = false;
      this.$emit('response-complete', content); // Emit the complete content
    },
  },
};
</script>
