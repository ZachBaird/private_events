Rails.application.routes.draw do
  devise_for :users
  resources :events
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'events#index'
  get '/users/:id', to: 'users#show'
  post '/events/attend/:id', to: 'events#attend_event'
  delete '/events/unattend/:id', to: 'events#unattend_event'
end
