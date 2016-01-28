Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :agencies
  resources :grants do
    member do
      patch :update_controls
    end
    resources :budgets, only: [:index]
  end

  root 'grants#index'
end
