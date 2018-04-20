Rails.application.routes.draw do
=begin 
  root 'trainings#new'
  post '/' => 'trainings#create'
  get '/trainings' => 'trainings#index'
  get '/trainings/:id' => 'trainings#edit', as: 'training'
  post '/trainings/:id' => "trainings#update"
  resources :trainings
=end
  get '/logs/inactive' => 'logs#inactive', as: 'inactive_logs'
  root 'logs#index'
  resources :logs do
    resources :trainings
  end
  
  get '/public/404.html' => 'logs#index'
  
  get '/request' => 'tickets#new'
  get '/support' => 'tickets#support'
  post '/request' => 'tickets#create'
  post '/support' => 'tickets#create'
  get '/thanks' => 'tickets#thanks'
  get '/about' => 'tickets#about'
  
  
end
