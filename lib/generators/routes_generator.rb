# frozen_string_literal: true

class RoutesGenerator < Rails::Generators::Base
  argument :models, type: :array

  def create_model_file
    create_file "config/routes.rb", <<-FILE
Rails.application.routes.draw do
  root to: "admin/dashboard#index"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)  
  namespace :api do   
    #{resources}
  end
end    
    FILE
  end

  def resources
    models.map { |model| "resources :#{model.pluralize.underscore}" }.join("\n    ")
  end
end