import { createApp } from 'vue'
import './style.css'
import App from './App.vue'
import router from './router'
import { FontAwesomeIcon } from './plugins/font-awesome';
import VueDOMPurifyHTML from 'vue-dompurify-html';

const app = createApp(App);
app.component('font-awesome-icon', FontAwesomeIcon);
app.use(router);
app.use(VueDOMPurifyHTML);
app.mount('#app');
