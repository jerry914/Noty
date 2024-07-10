<template>
  <div>
    <nav>
      <router-link to="/">Home</router-link>
      <router-link to="/terms">Terms</router-link>
    </nav>
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name: 'App'
}
</script>

<style>
nav {
  padding: 1em;
}
nav a {
  margin: 0 1em;
  text-decoration: none;
  color: #42b983;
}
nav a.router-link-active {
  font-weight: bold;
}
</style>
