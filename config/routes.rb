  Rails.application.routes.draw do
    root to: 'pages#index'
    resources :claims
    resources :insurance_policies
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
  end
