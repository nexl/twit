<template>
  <div id="tweet">
    <div class="row">
      <div class="col-sm-8">
        <input v-model="newTweet" v-on:keyup.enter="addTweet" placeholder="new tweet" type="=text" class="form-control">
        <input v-model="userId" type="hidden" value="<%= @current_user.id %>">
        <input v-model="userAvatar" type="hidden" value="<%= @current_user.avatar.url %>">
      </div>

      <div class="col-sm-2">
        <button v-on:click="addTweet" class="btn btn-primary" type="button">tweet!</button>
      </div>
    </div>
    <br/>
    <div v-if="loading">loading ... please wait </div>
    <div v-else>
      <div class="row tweet" v-for="tweet in tweets">

        <div class="col-sm-2">
          <a v-bind:href="tweet.user.user_url" class="link-user">
            <img class="avatar" v-bind:src="tweet.user.avatar_url" v-if="tweet.user.avatar_url != 'default_avatar.png'">
            <img class="avatar" src="http://res.cloudinary.com/dspao5qq9/image/upload/v1523551250/default_iposxk.png" v-if="tweet.user.avatar_url == 'default_avatar.png'">
          </a>
        </div>

        <div class="col-sm-10">
          <div class="row">
            <a v-bind:href="tweet.user.user_url" class="link-user">
             {{tweet.user.username}} - {{tweet.created_at_format}}
            </a>
          </div>

          <div class="row">
            <p>{{tweet.message}}</p>
          </div>

          <button v-on:click="writeComment(tweet)" class="btn btn-primary">write comment</button>

          <button v-if="Object.keys(tweet.comment_tweet).length > 0" v-on:click="showComment(tweet)" class="btn btn-primary">show comment</button>
          
          <div v-if="newComment == tweet.id">
            <input v-model="anotherTweet" v-on:keyup.enter="addComment(tweet)" placeholder="comment tweet" type="=text" class="form-control">
          </div>
          
          <div v-if="detail == tweet.id">
            <div class="row" v-for="comment in tweet.comment_tweet">
              <div class="col-sm-2">
              <a v-bind:href="comment.user.user_url" class="link-user">
                <img class="avatar" v-bind:src="comment.user.avatar_url">
              </a>
            </div>

            <div class="col-sm-10">
              <div class="row">
                <a v-bind:href="comment.user.user_url" class="link-user">
                 {{comment.user.username}} - {{comment.created_at_format}}
                </a>
              </div>

              <div class="row">
                <p>{{comment.message}}</p>
              </div>
            </div>
            <br>
          </div>
        </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'tweet',
  data() {
    return{  
      message: '',
      tweets: '',
      newTweet: '',
      newComment: '',
      userId: '',
      detail: '',
      anotherTweet: '',
      userAvatar: '',
      loading: true
    }
  },
  mounted(){
    var temp = this;
    $.ajax({
      url: '/feed.json',
      success(result){
        temp.tweets = result;
        temp.loading = false;
      },
      error(xhr, ajaxOptions, thrownError){
        console.log(xhr.responseText);
      }
    })
  },
  methods: {
    writeComment(tweet){
      if(this.newComment == tweet.id) this.newComment = false;
      else this.newComment = tweet.id;
    },
    showComment(tweet) {
      if(this.detail == tweet.id) this.detail = false;
      else this.detail = tweet.id;
    },
    addComment(tweet){
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
          success(result){
            temp.newComment = false;
            tweet.comment_tweet.unshift(result);
            temp.tweets.unshift(result);
          },
          error(xhr, ajaxOptions, thrownError){
            console.log(xhr.responseText);
          }
        })
      }
      this.anotherTweet = ""
    },
    addTweet(){
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
          success(result){
            temp.tweets.unshift(result);
          },
          error(xhr, ajaxOptions, thrownError){
            console.log(xhr.responseText);
          }
        })
      }
      this.newTweet = ""
    }
  }
}
</script>