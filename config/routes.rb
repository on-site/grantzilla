Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :grants do
    member do
      patch :update_controls
    end
  end

  root 'grants#index'
end
