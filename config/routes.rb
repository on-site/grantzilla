Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :grants

  root 'grants#index'
end
