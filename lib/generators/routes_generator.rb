class RoutesGenerator < Rails::Generators::Base
  argument :models, type: :array

  def create_model_file
    create_file "config/routes.rb", <<-FILE
Rails.application.routes.draw do
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