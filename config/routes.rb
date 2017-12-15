Rails.application.routes.draw do
  devise_for :students
  devise_for :teachers
  root to: 'front#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
