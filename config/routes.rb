Rails.application.routes.draw do
  root 'trainings#new'
  post '/' => 'trainings#create'
  get '/trainings' => 'trainings#index'
end
