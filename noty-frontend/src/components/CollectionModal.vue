<template>
    <div class="modal-overlay" @click.self="close">
      <div class="modal-content">
        <h2>{{ title }}</h2>
        <slot></slot>
        <div class="modal-buttons">
          <button v-if="cancelButtonText" @click="close">{{ cancelButtonText }}</button>
          <button v-if="confirmButtonText" @click="confirm">{{ confirmButtonText }}</button>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    props: {
      title: {
        type: String,
        required: true
      },
      cancelButtonText: {
        type: String,
        default: 'Cancel'
      },
      confirmButtonText: {
        type: String,
        default: 'Confirm'
      }
    },
    methods: {
      close() {
        this.$emit('close');
      },
      confirm() {
        this.$emit('confirm');
      }
    }
  }
  </script>
  
  <style scoped>
  .modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000;
  }
  
  .modal-content {
    background-color: white;
    padding: 2rem;
    border-radius: 8px;
    width: 90%;
    max-width: 500px;
    position: relative;
  }
  
  .modal-buttons {
    display: flex;
    justify-content: flex-end;
    margin-top: 1rem;
  }
  
  .modal-buttons button {
    margin-left: 0.5rem;
    padding: 0.5rem 1rem;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }
  
  .modal-buttons button:first-child {
    background-color: #e5e5e5;
  }
  
  .modal-buttons button:last-child {
    background-color: #4CAF50;
    color: white;
  }
  </style>
  