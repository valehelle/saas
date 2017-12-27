Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'front#index'
  get '/dashboard/', to: 'dashboard#index'
  get '/announcements/new', to: 'announcement#new'
  post '/announcements/', to: 'announcement#create'
  get '/subjects/', to: 'subject#index'
  get '/subjects/:id', to: 'subject#show', as: 'subject'
  get '/about/', to: 'front#about'
  get '/gallery/', to: 'front#gallery'
  get '/contact/', to: 'front#contact'
  get '/faq/', to: 'front#faq'
  get '/service/', to: 'front#service'
  get '/material/', to: 'front#material'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
