Rails.application.routes.draw do
  get 'home/index'

  # Devise routes
  devise_for :users, controllers: { registrations: 'registrations' }
  get 'admins/unverified_users', to: 'admins#unverified_users', as: 'unverified_users'
  put 'admins/verify_user/:id', to: 'admins#verify_user', as: 'verify_user'
  
  # Courses routes
  resources :courses do
    collection do
      post 'fetch_classes'
    end
  end

  # Set root index
  root 'home#index'
end
