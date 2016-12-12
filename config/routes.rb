Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :posts do
    resources :comments
  end
  root 'posts#index'

  get 'en', to: 'application#locale_en'
  get 'ru', to: 'application#locale_ru'

  get 'signup'  => 'users#new'
  resources :users

  get '/login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
