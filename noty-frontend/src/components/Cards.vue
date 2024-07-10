<template>
  <div class="cards">
    <Card
      v-for="(card, index) in cards"
      :key="index"
      :question="card.question"
      :answer="card.answer"
      @archive="archiveCard(index)"
      @update-answer="updateCard(index, $event)"
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
    updateCard(index, updatedAnswer) {
      this.$emit('update-card', index, updatedAnswer)
    },
  },
}
</script>

<style scoped>

</style>
