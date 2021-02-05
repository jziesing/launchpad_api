  Rails.application.routes.draw do
    resources :insurance_policies
    root to: "admin/dashboard#index"
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
  end
