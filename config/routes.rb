Rails.application.routes.draw do
  devise_for :students
  devise_for :teachers
  root to: 'front#index'
  get '/about/', to: 'front#about'
  get '/gallery/', to: 'front#gallery'
  get '/contact/', to: 'front#contact'
  get '/faq/', to: 'front#faq'
  get '/service/', to: 'front#service'
  get '/material/', to: 'front#material'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
