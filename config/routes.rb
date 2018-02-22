Rails.application.routes.draw do
  devise_for :users
  match '/login', to: 'login#user_login', constraints: { subdomain: /.+/ }, via: [:get], as: 'login'
  match '/login', to: 'login#user_sign_in', constraints: { subdomain: /.+/ }, via: [:post], as: 'sign_in'
  match '/logout', to: 'login#user_sign_out', constraints: { subdomain: /.+/ }, via: [:delete], as: 'logout'
  
  match '/dashboard', to: 'dashboard#index', constraints: { subdomain: /.+/ }, via: [:get]
  match '/subjects/:id/announcements/', to: 'subject#announcements', constraints: { subdomain: /.+/ }, via: [:get], as: 'subject_announcements'
  match '/subjects/:id/documents/new', to: 'document#new', constraints: { subdomain: /.+/ }, via: [:get], as: 'new_documents'
  match '/subjects/:id/documents/', to: 'document#create', constraints: { subdomain: /.+/ }, via: [:post], as: 'documents'

  match '/subjects/:id/documents/:doc_id/download', to: 'document#download_file', constraints: { subdomain: /.+/ }, via: [:get], as: 'download_document'
  match '/subjects/:id/documents/:doc_id/download', to: 'document#delete_file', constraints: { subdomain: /.+/ }, via: [:delete], as: 'delete_document'
  match '/announcements', to: 'announcement#index', constraints: { subdomain: /.+/ }, via: [:get]
  match '/announcements/new', to: 'announcement#new', constraints: { subdomain: /.+/ }, via: [:get]
  match '/announcements/:id', to: 'announcement#show', constraints: { subdomain: /.+/ }, via: [:get], as: 'announcement'
  match '/announcements/', to: 'announcement#create', constraints: { subdomain: /.+/ }, via: [:post]
  match '/announcements/:id', to: 'announcement#destroy', constraints: { subdomain: /.+/ }, via: [:delete], as: 'delete_announcement'
  match '/subjects/', to: 'subject#index', constraints: { subdomain: /.+/ }, via: [:get]
  match '/subjects/:id', to: 'subject#show', constraints: { subdomain: /.+/ }, via: [:get], as: 'subject'


  get '/about/', to: 'front#about'
  get '/gallery/', to: 'front#gallery'
  get '/contact/', to: 'front#contact'
  get '/faq/', to: 'front#faq'
  get '/users/register', to: 'login#admin_register', as: 'user_register'
  post '/users/register', to: 'login#admin_create'
  resources :admin_user, path: 'admin/admin_user'
  resources :admin_teacher, path: 'admin/admin_teacher'
  resources :admin_student, path: 'admin/admin_student'
  resources :admin_subject, path: 'admin/admin_subject'
  resources :admin_announcement, path: 'admin/admin_announcement'
  get 'admin/profile', to: 'admin_profile#show', as: 'admin_profile'
  get 'admin/profile/edit', to: 'admin_profile#edit', as: 'admin_profile_edit'
  patch 'admin/profile/edit', to: 'admin_profile#update'
  root to: 'front#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
