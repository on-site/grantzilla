Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :grants do
    resources :budgets, only: [:index]
  end

  root 'grants#index'
end
