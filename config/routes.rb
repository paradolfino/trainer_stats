Rails.application.routes.draw do
  root 'trainings#new'
  post '/' => 'trainings#create'
  get '/trainings' => 'trainings#index'
  get '/trainings/:id' => 'trainings#edit', as: 'training'
  post '/trainings/:id' => "trainings#update"
  resources :trainings
end
