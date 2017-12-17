Rails.application.routes.draw do
  devise_for :students
  devise_for :teachers
  root to: 'front#index'
  get '/document/', to: 'front#new', as: 'documents'
  post '/document/', to: 'front#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
