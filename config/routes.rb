Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :grants
  resources :agencies

  root 'grants#index'
end
