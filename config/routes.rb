Rails.application.routes.draw do
  resources :grants

  root 'grants#index'
end
