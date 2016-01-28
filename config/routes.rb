Rails.application.routes.draw do
  devise_for :users
  resources :grants do
    resources :forms
  end

  root 'grants#index'
end
