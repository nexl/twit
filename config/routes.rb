Rails.application.routes.draw do

  resources :users 
  resources :tweets, :only => [:create]
  resources :follows, :only => [:create, :destroy]
  
  get     '/login',         :to => 'sessions#new'
  get     '/activate/:id',  :to => 'users#activate',  :as => :activate
  get     'feed',           :to => 'users#feed',      :as => :feed
  post    '/login',         :to => 'sessions#create'
  delete  '/logout',        :to => 'sessions#destroy'
  root :to => 'users#new'
end
