Rails.application.routes.draw do

  # STRIPE 
  scope '/checkout' do
    post 'create', to: 'checkout#create', as: '/checkout_create'
    get 'success', to: 'checkout#success', as: '/checkout_success'
    get 'cancel', to: 'checkout#cancel', as: '/checkout_cancel'
  end

  get 'static_pages/secret'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # resources :users, only: [:show]
  resources :events
  resources :attendances
  resources :users, only:[:show]
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "events#index"
end
