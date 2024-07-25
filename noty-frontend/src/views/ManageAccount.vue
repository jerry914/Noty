<template>
  <div class="manage-account-container">
    <h1>Manage Account</h1>
    <div v-if="account" class="account-details">
      <img :src="account.avatar" alt="Avatar" class="avatar">
      <p><strong>Name:</strong> {{ account.name }}</p>
      <p><strong>Email:</strong> {{ account.email }}</p>
      <p><strong>LLMS Secret Exist: </strong> 
        <font-awesome-icon v-if="account.exist_llms_secret=='yes'" :icon="['fas', 'square-check']" style="color: #aad13d;" />
        <font-awesome-icon v-else :icon="['fas', 'square-xmark']" style="color: #f04c4c;" />
        {{ account.exist_llms_secret }}
      </p>
      <div class="update-section">
        <label for="new-llms-secret">Update LLMS Secret:</label>
        <input
          type="text"
          id="new-llms-secret"
          v-model="newLlmsSecret"
          placeholder="Enter new LLMS secret"
        />
        <button @click="updateLlmsSecret">Update</button>
      </div>
    </div>
    <div v-else>
      <p>Loading account details...</p>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      account: null,
      newLlmsSecret: ''
    };
  },
  mounted() {
    this.fetchAccountDetails();
  },
  methods: {
    async fetchAccountDetails() {
      try {
        const response = await fetch('/api/accounts', {
          credentials: 'include'
        });
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        this.account = await response.json();
        console.log(this.account)
      } catch (error) {
        console.error('Error fetching account details:', error);
      }
    },
    async updateLlmsSecret() {
      try {
        const response = await fetch('/api/accounts', {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json'
          },
          credentials: 'include',
          body: JSON.stringify({ llms_secret: this.newLlmsSecret })
        });
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        const updatedAccount = await response.json();
        this.account.llms_secret = updatedAccount.llms_secret;
        this.newLlmsSecret = '';
        alert('LLMS secret updated successfully');
      } catch (error) {
        console.error('Error updating LLMS secret:', error);
      }
    }
  }
}
</script>

<style scoped>
.manage-account-container {
  max-width: 600px;
  margin: auto;
  padding: 2rem;
  background-color: #f9f9f9;
  border-radius: 8px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.account-details {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
}

.avatar {
  width: 100px;
  height: 100px;
  border-radius: 50%;
  margin-bottom: 1rem;
}

.update-section {
  margin-top: 2rem;
}

.update-section label {
  display: block;
  margin-bottom: 0.5rem;
}

.update-section input {
  width: 100%;
  padding: 0.5rem;
  margin-bottom: 1rem;
  border: 1px solid #ccc;
  border-radius: 4px;
}

.update-section button {
  padding: 0.5rem 1rem;
  border: none;
  border-radius: 4px;
  background-color: #007bff;
  color: #fff;
  cursor: pointer;
}

.update-section button:hover {
  background-color: #0056b3;
}
</style>
