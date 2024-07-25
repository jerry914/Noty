<template>
  <div class="cards">
    <Card
      v-for="(card, index) in cards"
      :key="index"
      :title="card.title"
      :content="card.content"
      @archive="archiveCard(index)"
      @update-content="updateCard(index, $event)"
    />
  </div>
</template>

<script>
import Card from './Card.vue'

export default {
  components: {
    Card,
  },
  props: {
    cards: {
      type: Array,
      required: true,
    },
  },
  methods: {
    archiveCard(index) {
      this.$emit('archive-card', index)
    },
    updateCard(index, updatedContent) {
      this.$emit('update-card', index, updatedContent)
    },
  },
}
</script>

<style scoped>

</style>
