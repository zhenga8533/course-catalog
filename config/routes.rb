Rails.application.routes.draw do
  # User routes
  resources :profiles, only: [:show]
  devise_for :users, controllers: { registrations: 'registrations' }
  devise_scope :user do
    get '/users/availability', to: 'registrations#availability', as: 'user_availability'
    put '/users/availability', to: 'registrations#update_availability'
  end

  resources :recommendations
  resources :student_applications
  
  get 'admins/dashboard', to: 'admins#dashboard', as: 'dashboard'
  put 'admins/verify_user/:id', to: 'admins#verify_user', as: 'verify_user'
  
  # Courses routes
  resources :courses do
    resources :sections, only: [:show, :new, :create, :edit, :update, :destroy]
    collection do
      post 'fetch_classes'
    end
  end
  
  delete 'clear_classes', to: 'courses#clear_classes', as: 'clear_classes'

  # Set root index
  root 'home#index'
end
