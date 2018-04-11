import Vue from 'vue/dist/vue.esm'
import Tweet from '../components/tweet.vue'

Vue.component('tweet', {
  components: { Tweet },
  template: '<Tweet/>'
})

new Vue({
    el: '#apps'
})