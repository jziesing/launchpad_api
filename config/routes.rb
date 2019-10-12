Rails.application.routes.draw do
  namespace :api do
    resources :accounts
  end
end
