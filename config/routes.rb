Rails.application.routes.draw do
  root 'blogs#index'

  get '/blogs', to: 'blogs#index'
  get '/blogs/:id', to: 'blogs#show'

  get '/projects', to: 'projects#index'

  get '/about', to: 'about#index'
end
