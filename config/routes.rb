Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :garages, except: [:destroy, :update, :edit] do
    resources :cars, except: [:destroy, :update, :edit] do
      resources :invoices, except: [:destroy, :update, :edit, :new, :create]
      resources :contracts, except: [:destroy, :update, :edit, :new, :create]
      resources :trips, except: [:destroy, :update, :edit, :new, :create]
    end
  end

  resources :garages, only: [:destroy, :update, :edit]
  resources :cars, only: [:destroy, :update, :edit]
  resources :invoices, only: [:destroy, :update, :edit, :new, :create]
  resources :contracts, only: [:destroy, :update, :edit, :new, :create]
  resources :trips, only: [:destroy, :update, :edit, :new, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
