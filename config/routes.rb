FirstApp::Application.routes.draw do
  resources :users

  resources :sessions, :only => [:new, :create, :destroy]

  root :to => 'pages#home'

  match '/home', :to => 'pages#home'

  match '/contact', :to => 'pages#contact'

  match '/about',   :to => 'pages#about'
  
  match '/help',    :to => 'pages#help'

  match '/signup', :to => 'users#new'

  match '/signin', :to => 'sessions#new'

  match '/signout', :to => 'sessions#destroy'

  match '/404', :to => 'errors#not_found'

  match '/books',    :to => 'book#search'

  match '/book-info', :to => 'book#info'

  match '/oauth', :to => 'pages#oauth'
end
