Rails.application.routes.draw do
  root 'blogs#index'

  get '/blog', to: 'blogs#index'
  get '/blogs', to: 'blogs#index'
  get '/blog/:id', to: 'blogs#show'
  get '/blogs/:id', to: 'blogs#show'

  get '/projects', to: 'projects#index'
end
