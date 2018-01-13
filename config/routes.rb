Rails.application.routes.draw do
  devise_for :users
  root to: 'front#index'
  get '/subjects/:id/announcements/', to: 'subject#announcements', as: 'subject_announcements'
  get '/subjects/:id/documents/new', to: 'document#new', as: 'new_documents'
  post '/subjects/:id/documents/', to: 'document#create', as: 'documents'
  get '/subjects/:id/documents/:doc_id/download', to: 'document#download_file', as: 'download_document'
  delete '/subjects/:id/documents/:doc_id/download', to: 'document#delete_file', as: 'delete_document'
  get '/dashboard/', to: 'dashboard#index'
  get '/announcements', to: 'announcement#index'
  get '/announcements/new', to: 'announcement#new'
  get '/announcements/:id', to: 'announcement#show', as: 'announcement'
  post '/announcements/', to: 'announcement#create'
  delete '/announcements/:id', to: 'announcement#destroy', as: 'delete_announcement'
  get '/subjects/', to: 'subject#index'
  get '/subjects/:id', to: 'subject#show', as: 'subject'
  get '/about/', to: 'front#about'
  get '/gallery/', to: 'front#gallery'
  get '/contact/', to: 'front#contact'
  get '/faq/', to: 'front#faq'
  get '/service/', to: 'front#service'
  get '/material/', to: 'front#material'
  get '/:company_id/login', to: 'login#user_login', as: 'login'
  post '/:company_id/login', to: 'login#user_sign_in', as: 'sign_in'
  resources :admin_user, path: 'admin/admin_user'
  resources :admin_teacher, path: 'admin/admin_teacher'
  resources :admin_student, path: 'admin/admin_student'
  resources :admin_subject, path: 'admin/admin_subject'
  resources :admin_announcement, path: 'admin/admin_announcement'
  get 'admin/profile', to: 'admin_profile#show', as: 'admin_profile'
  get 'admin/profile/edit', to: 'admin_profile#edit', as: 'admin_profile_edit'
  patch 'admin/profile/edit', to: 'admin_profile#update'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
