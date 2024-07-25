<template>
    <div class="card-container">
        <div class="card" @click="openCard">
            <div class="note-title">
            {{ title }}
            </div>
            <div class="note-content" v-html="content"></div>
            <button class="archive-button" @click.stop="archiveCard"><font-awesome-icon :icon="['fas', 'box-archive']" /></button>
        </div>
        <div v-if="isOpen" class="modal" @click.self="closeCard">
            <div class="modal-content">
                <h2>{{ title }}</h2>
                <button class="archive-button" @click.stop="archiveCard">
                <font-awesome-icon :icon="['fas', 'box-archive']" />
                </button>
                <TipTapEditor v-model="editedContent" />
                <div class="ai-response-text">
                    <span v-for="message in messages" :key="message">
                        {{ message }}
                    </span>
                </div>
                <button @click="sendMessage" class="ask-ai"><font-awesome-icon :icon="['fas', 'paper-plane']" /> Ask AI</button>
                <div style="float: right;">
                    <button @click="closeCard" class="close">Cancel</button>
                    <button @click="saveEdit" class="save">Save</button>
                </div>
            </div>
        </div>
        <StreamingComponent v-if="currentTitle" :title="currentTitle" @response-chunk="handleChunk" @response-complete="handleComplete" />
    </div>
</template>

<script>
import TipTapEditor from './TipTapEditor.vue'
import StreamingComponent from './StreamingComponent.vue';

export default {
  components: {
    TipTapEditor,
    StreamingComponent,
  },
  props: {
    title: {
      type: String,
      required: true
    },
    content: {
      type: String,
      required: true
    }
  },
  data() {
    return {
      isOpen: false,
      editedContent: this.content,
      currentTitle: '',
      isResponsing: false,
      messages: []
    };
  },
  methods: {
    sendMessage() {
      if (this.isResponsing) return;
      this.currentTitle = this.editedContent;
      this.isResponsing = true;
      
    },
    handleChunk(chunk) {
      this.messages.push(chunk);
    },
    handleComplete(content) {
      this.isResponsing = false;
      this.editedContent += this.messages.join('');
      this.messages = [];
    },
    openCard() {
      this.isOpen = true;
      this.editedContent = this.content;
    },
    closeCard() {
      this.isOpen = false;
    },
    archiveCard() {
      this.$emit('archive');
    },
    saveEdit() {
      this.$emit('update-content', this.editedContent);
      this.closeCard();
    }
  }
}
</script>

<style scoped>
.card {
  border: 1px solid #ccc;
  border-radius: 8px;
  padding: 1rem;
  background-color: #f9f9f9;
  max-height: 440px;
  max-width: 300px;
  overflow-y: hidden;
  cursor: pointer;
  position: relative;
  transition: box-shadow 0.3s ease;
  display: inline-block;
  width: 100%;
}

.card:hover {
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.archive-button {
  position: absolute;
  top: 10px;
  right: 10px;
  border: none;
  background-color: #4a4a4a;
  color: white;
  padding: 0.5rem;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.archive-button:hover {
  background-color: #ff1c1c;
}

.note-title,
.note-content {
  margin-bottom: 0.5rem;
}

.note-title {
  font-size: 1.1rem;
  font-weight: 700;
  width: calc( 100% - 30px );
}

.modal {
  display: flex;
  align-items: center;
  justify-content: center;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  z-index: 1000;
}

.modal-content {
  background-color: white;
  padding: 2rem;
  border-radius: 8px;
  max-width: 1200px;
  max-height: 90vh;
  overflow-y: auto;
  width: 80%;
  position: relative;
}

.modal-content > h2 {
  margin: 0 5px 0 0;
}
.ask-ai {
  background-color: rgb(198, 238, 191);
}
.save {
  background-color: #d3edff;
  margin-left: 10px;
}
.close {
  background-color: #e5e5e5;
}
.ai-response-text {
    margin: 10px 0;
    background-color: #f8fff7;
}
</style>
