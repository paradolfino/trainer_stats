Rails.application.routes.draw do
=begin 
  root 'trainings#new'
  post '/' => 'trainings#create'
  get '/trainings' => 'trainings#index'
  get '/trainings/:id' => 'trainings#edit', as: 'training'
  post '/trainings/:id' => "trainings#update"
  resources :trainings
=end
  root 'logs#index'
  resources :logs do
    resources :trainings
    
  end
end
