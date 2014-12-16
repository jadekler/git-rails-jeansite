Rails.application.routes.draw do
  root 'blogs#index'

  resources :blogs

  get '/projects', to: 'projects#index'
end
