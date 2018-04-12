# Twit

Twit is a simple twitter-app that allows user to:
* Register
* Follow and unfollow user
* Tweet and comment a tweet

### Specs
* Ruby 2.4.0
* Rails 5.1.6
* Vue 2.5.16
* SQLite

### Installation

```sh
cd ~/site
$ git clone git@github.com:nexl/twit.git
$ bundle install
$ rake db:create
$ rake db:migrate
$ yarn install
```

### Start local servers
```sh
rails s (backend / rails)
bin/webpack-dev-server (frontend / webpack)
```

### Settings 

* config/database.yml -> database settings
* config/local_env.yml -> email auth, default smtp setting is gmail
