<template>
  <div>
    <div class="login-container">Login</div>
    <div class="login-btn" @click="loginWithGoogle">
      <img class="login-icon-img" src="../assets/google_icon.png" width="50" height="50"/>
      <div class="login-icon-text">Sign in with Google</div>
    </div>

    <div v-if="isLoading" class="loading-container">
      <font-awesome-icon :icon="['fas', 'spinner']" spin-pulse size="2xl" style="color: #FFD43B;" />
    </div>
  </div>
</template>

<script>

export default {
  name: 'LoginPage',

  data() {
    return {
      isLoading: false
    };
  },
  created() {
    this.handleGoogleCallback();
  },
  methods: {
    loginWithGoogle() {
      window.location.href = 'http://0.0.0.0:9292/auth/google';
    },
    async handleGoogleCallback() {
      const query = new URLSearchParams(window.location.search);
      const code = query.get('code');

      if (code) {
        this.isLoading = true;
        try {
          const response = await fetch(`http://0.0.0.0:9292/auth/google/callback?code=${code}`, {
            credentials: 'include'
          });
          this.isLoading = false;
          const data = await response.json();

          if (response.ok) {
            this.storeLoginData(data);
            this.$router.push("/")
          } else {
            console.error('Login failed', data);
          }
        } catch (error) {
          console.error('Error during the login process', error);
        }
      }
    },
    storeLoginData(data) {
      localStorage.setItem('account', JSON.stringify(data.account));
    }
  }
};
</script>

<style scoped>
p {
  margin-top: 12px;
}
.loading-container {
  position: absolute;
  width: 100%;
  height: 100%;
  background-color: #fffc;
  top: 0;
  left: 0;
  text-align: center;
  padding: 20% 0;
}

.login-container {
  font-size: 2.5rem;
  font-weight: 700;
  text-align: center;
  margin: 40px 0;
}
.login-btn {
  display: flex;
  justify-content: center;
  background-color: #fff;
  padding: 5px 5px;
  width: 260px;
  margin: auto;
  border-radius: 10px;
  cursor: pointer;
  box-shadow: 0 2px 4px rgba(0, 0, 0, .12), 0 0 6px rgba(0, 0, 0, .04);
}
.login-icon-img {
  display: inline;
}
.login-icon-text {
  display: inline;
  line-height: 50px;
  margin-left: 10px;
}
</style>
