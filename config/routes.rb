Rails.application.routes.draw do
  devise_for :users
  resources :grants

  root 'grants#index'
end
