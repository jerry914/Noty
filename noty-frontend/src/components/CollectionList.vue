<template>
  <div class="collection-container">
    <button class="create-button" @click="openCreateModal">Create Collection</button>
    <div v-for="collection in collections" :key="collection.id" class="collection-box">
      <div @click="navigateToCollection(collection.id)" class="collection-name">
        {{ collection.name }}
      </div>
      <button class="manage-button" @click.stop="openManageModal(collection)">Manage</button>
      <button class="delete-button" @click.stop="openDeleteModal(collection)">Delete</button>
    </div>

    <collection-modal
      v-if="showCreateModal"
      :title="'Create Collection'"
      @close="closeCreateModal"
      @confirm="createCollection"
      :confirmButtonText="'Create'"
    >
      <input v-model="newCollection.name" placeholder="Name" />
      <input v-model="newCollection.prompt" placeholder="Prompt" />
    </collection-modal>

    <collection-modal
      v-if="showManageModal"
      :title="'Manage Collection'"
      @close="closeManageModal"
      @confirm="updateCollection"
      :confirmButtonText="'Save'"
    >
      <input v-model="selectedCollection.name" placeholder="Name" />
      <input v-model="selectedCollection.prompt" placeholder="Prompt" />
    </collection-modal>

    <collection-modal
      v-if="showDeleteModal"
      :title="'Confirm Delete'"
      @close="closeDeleteModal"
      @confirm="deleteCollection"
      :confirmButtonText="'Yes'"
      :cancelButtonText="'No'"
    >
      <p>Are you sure you want to delete {{ selectedCollection.name }}?</p>
    </collection-modal>
  </div>
</template>

<script>
import CollectionModal from './CollectionModal.vue'; // Import the modal component

export default {
  components: {
    CollectionModal
  },
  data() {
    return {
      collections: [],
      showCreateModal: false,
      showManageModal: false,
      showDeleteModal: false,
      newCollection: { name: '', prompt: '' },
      selectedCollection: null
    };
  },
  mounted() {
    this.fetchCollections();
  },
  methods: {
    async fetchCollections() {
      try {
        const response = await fetch('/api/collections', {
          credentials: 'include'
        });
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        this.collections = await response.json();
      } catch (error) {
        console.error('Error fetching collections:', error);
      }
    },
    navigateToCollection(id) {
      this.$router.push(`/collections/${id}`);
    },
    openCreateModal() {
      this.showCreateModal = true;
    },
    closeCreateModal() {
      this.showCreateModal = false;
      this.newCollection = { name: '', prompt: '' };
    },
    async createCollection() {
      try {
        const response = await fetch('/api/collections', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          credentials: 'include',
          body: JSON.stringify(this.newCollection)
        });
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        this.fetchCollections();
        this.closeCreateModal();
      } catch (error) {
        console.error('Error creating collection:', error);
      }
    },
    openManageModal(collection) {
      this.selectedCollection = { ...collection };
      this.showManageModal = true;
    },
    closeManageModal() {
      this.showManageModal = false;
      this.selectedCollection = null;
    },
    async updateCollection() {
      try {
        let updataCollection = {
            name: this.selectedCollection.name,
            prompt: this.selectedCollection.prompt
        }
        const response = await fetch(`/api/collections/${this.selectedCollection.id}`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json'
          },
          credentials: 'include',
          body: JSON.stringify(updataCollection)
        });
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        this.fetchCollections();
        this.closeManageModal();
      } catch (error) {
        console.error('Error updating collection:', error);
      }
    },
    openDeleteModal(collection) {
      this.selectedCollection = collection;
      this.showDeleteModal = true;
    },
    closeDeleteModal() {
      this.showDeleteModal = false;
      this.selectedCollection = null;
    },
    async deleteCollection() {
      try {
        const response = await fetch(`/api/collections/${this.selectedCollection.id}`, {
          method: 'DELETE',
          credentials: 'include'
        });
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        this.fetchCollections();
        this.closeDeleteModal();
      } catch (error) {
        console.error('Error deleting collection:', error);
      }
    }
  }
}
</script>

<style scoped>
.collection-container {
  max-width: 800px;
  margin: auto;
  padding: 1rem;
}

.create-button {
  background-color: #4CAF50;
  color: white;
  padding: 0.5rem 1rem;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  margin-bottom: 1rem;
}

.collection-box {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0.5rem;
  border: 1px solid #ccc;
  border-radius: 4px;
  margin-bottom: 0.5rem;
}

.collection-name {
  cursor: pointer;
  flex-grow: 1;
}

.manage-button, .delete-button {
  background-color: #f0f0f0;
  border: none;
  padding: 0.5rem;
  border-radius: 4px;
  cursor: pointer;
  margin-left: 0.5rem;
}

.manage-button:hover {
  background-color: #ddd;
}

.delete-button:hover {
  background-color: #ff1c1c;
  color: white;
}
</style>
