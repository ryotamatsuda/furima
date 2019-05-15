Rails.application.routes.draw do

  get "items/sold"=>"items#sold"
  get "items/bought"=>"items#bought"
  get "items/am_selling"=>"items#am_selling"
  post "items/create"=>"items#create"
  get "items/new"=>"items#new"
  get "items/on_sale"=>"items#on_sale"
  get 'items/index'=>"items#index"
  get "items/:id"=>"items#show"
  get "items/:id/edit"=>"items#edit"
  post "items/:id/update"=>"items#update"
  post "items/:id/destroy"=>"items#destroy"
  get "items/:id/buy_form"=>"items#buy_form"
  post "items/:id/buy"=>"items#buy"

  post "login"=>"users#login"
  post "logout"=>"users#logout"
  get "login"=>"users#login_form"

  post "users/create"=>"users#create"
  get 'signup'=>"users#new"
  get "users/:id"=>"users#show"
  get "users/:id/edit"=>"users#edit"
  post "users/:id/update"=>"users#update"
  post "users/:id/destroy"=>"users#destroy"

  get '/'=>"home#top"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
