Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  resources :agencies

  resources :grants do
    resources :forms

    member do
      patch 'update_controls'
      post 'add_comment'
    end

    resources :budgets, only: [:index]
  end

  root 'grants#index'
end
