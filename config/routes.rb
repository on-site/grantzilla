# frozen_string_literal: true
Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  scope "/admin" do
    resources :users, only: [:index, :edit, :update, :destroy]
  end

  resources :agencies
  resources :uploads do
    member do
      get 'download'
    end
  end

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

  match "/401", to: "errors#unauthorized", via: :all
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
  get 'errors/internal_server_error'
  get 'errors/not_found'
  get 'errors/unauthorized'

  get "/.well-known/acme-challenge/:id",
      to: proc {
        [200,
         {},
         ["PVltCpMKHMFVvw2JnYNnsKovB8XNwbEm6iB_sjmTBvA.EOz8wpTt91fuDD0G0ziU0_tJHJNh11aZyXsVX3y7mro"]]
      }

  root 'grants#index'
end
