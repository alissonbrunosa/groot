Rails.application.routes.draw do
  resources :clients
  auth_for :users
end
