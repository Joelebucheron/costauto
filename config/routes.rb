Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :garages, except: [:destroy, :update, :edit] do
    resources :cars, except: [:destroy, :update, :edit]
  end

  resources :garages, only: [:destroy, :update, :edit]
  resources :cars, only: [:destroy, :update, :edit]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
