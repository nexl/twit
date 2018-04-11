import Vue from 'vue/dist/vue.esm'

document.addEventListener('DOMContentLoaded', () => {
  var tweet = new Vue({
    el: '#tweet',
    data: {
      tweets: [],
      newTweet: '',
      newComment: '',
      userId: '',
      detail: '',
      anotherTweet: '',
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
      writeComment: function (tweet) {
        if(this.newComment == tweet.id) this.newComment = false;
        else this.newComment = tweet.id;
      },
      showComment: function(tweet){
        if(this.detail == tweet.id) this.detail = false;
        else this.detail = tweet.id;
      },
      addComment: function(tweet){
        var temp = this;
        if(this.anotherTweet.length > 140) alert("Tweet should be less than 140 characaters");
        else if(this.anotherTweet.length == 0) alert("Tweet must be filled");
        else{
          $.ajax({
            method: 'POST',
            data:{
              tweet: {
                message: this.anotherTweet,
                user_id: this.userId,
                parent_id: tweet.id
              }
            },
            url: '/tweets.json',
            success: function(result){
              temp.newComment = false;
              tweet.comment_tweet.unshift(result);
              temp.tweets.unshift(result);
            },
            error: function(xhr, ajaxOptions, thrownError){
              console.log(xhr.responseText);
            }
          })
        }
        this.anotherTweet = ""        
      },
      addTweet: function(){
        var temp = this;
        if(this.newTweet.length > 140) alert("Tweet should be less than 140 characters");
        else if(this.newTweet.length == 0) alert("Tweet must be filed");
        else{
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
              console.log(xhr.responseText);
            }
          })
        }
        this.newTweet = ""
      }
    }
  })

})
