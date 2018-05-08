Rails.application.routes.draw do
  devise_for :users, :path_prefix => 'portal', :skip => 'registrations'
=begin 
  root 'trainings#new'
  post '/' => 'trainings#create'
  get '/trainings' => 'trainings#index'
  get '/trainings/:id' => 'trainings#edit', as: 'training'
  post '/trainings/:id' => "trainings#update"
  resources :trainings
=end
  
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'logout', to: 'devise/sessions#destroy'
  end
  scope '/admin' do
    resources :users
  end
  
  get '/logs/inactive' => 'logs#inactive', as: 'inactive_logs'
  root 'logs#index'
  resources :logs do
    resources :trainings
  end
  
  get '/public/404.html' => 'logs#index'
  
  get '/support' => 'tickets#new'
  post '/support' => 'tickets#create'
  get '/thanks' => 'tickets#thanks'
  get '/about' => 'tickets#about'
  
  
end
