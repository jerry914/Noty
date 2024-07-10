<template>
  <editor-content :editor="editor" class="custom-tiptap-editor" />
</template>

<script>
import Highlight from '@tiptap/extension-highlight'
import Typography from '@tiptap/extension-typography'
import StarterKit from '@tiptap/starter-kit'
import { Editor, EditorContent } from '@tiptap/vue-3'

export default {
  components: {
    EditorContent,
  },
  props: {
    modelValue: {
      type: String,
      default: '',
    },
  },

  emits: ['update:modelValue'],

  data() {
    return {
      editor: null,
    }
  },
  beforeUnmount() {
    this.editor.destroy()
  },
  watch: {
    modelValue(value) {
      const isSame = this.editor.getHTML() === value

      if (isSame) {
        return
      }

      this.editor.commands.setContent(value, false)
    },
  },
  mounted() {
    this.editor = new Editor({
    extensions: [
        StarterKit,
        Highlight,
        Typography,
    ],
    content: this.modelValue,
    onUpdate: () => {
        this.$emit('update:modelValue', this.editor.getHTML())
    }
    })
  }
}
</script>

<style scoped>
.tiptap :first-child {
    margin-top: 0;
}
.custom-tiptap-editor:deep(pre) {
    background: #333 !important;
    border-radius: 0.5rem;
    color: #fff;
    font-family: 'JetBrainsMono', monospace;
    margin: 1.5rem 0;
    padding: 0.75rem 1rem;
}
.custom-tiptap-editor:deep(code) {
    background: none;
    color: inherit;
    font-size: 0.8rem;
    padding: 0;
}

.custom-tiptap-editor:deep(p > code) {
    background: #dcecf2;
    padding: 0 3px;
    border-radius: 4px;
}
.custom-tiptap-editor:deep(p > mark) {
    background: #fce79a;
    padding: 0 3px;
    border-radius: 3px;
}

.custom-tiptap-editor {
    margin: 20px 0;
    line-height: 1.2rem;
}
.custom-tiptap-editor:deep(.tiptap:focus)  {
  outline: none;
  border: none;
  box-shadow: none;
}
.custom-tiptap-editor:deep(p) {
    margin: 1rem 0;
}
</style>