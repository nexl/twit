import Vue from 'vue/dist/vue.esm'
import App from '../components/app.vue'

document.addEventListener('DOMContentLoaded', () => {
   var my = new Vue({
    el: '#tweet',
    data: {
      tweets: [
      ],
      newTweet: '',
      userId: '',
      userAvatar: ''
    },
    mounted: function(){
      var temp = this;
      $.ajax({
        url: '/feed.json',
        success: function(result){
          temp.tweets = result;
        },
        error: function(){
        }
      })
    },
    methods: {
      addTweet: function(){
        var temp = this;
        if(this.newTweet.length > 140){ 
          alert("Should be 140")
          this.newTweet = ""
          return false;
        }
        $.ajax({
          method: 'POST',
          data:{
            tweet: {
              message: this.newTweet,
              user_id: this.userId,
            }
          },
          url: '/tweets.json',
          success: function(result){
            temp.tweets.unshift(result);
          },
          error: function(xhr, ajaxOptions, thrownError) {
            console.log(xhr.responseText)
          }
        })
        this.newTweet = ""
      }
    }
  })

})
