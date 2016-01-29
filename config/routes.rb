Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  resources :agencies

  resources :grants do
    member do
      patch 'update_controls'
      post 'add_comment'
    end

    resources :budgets, only: [:index] do
      collection do
        patch :bulk_update
      end
    end
    resources :forms
  end

  root 'grants#index'
end
