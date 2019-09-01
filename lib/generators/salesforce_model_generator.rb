class SalesforceModelGenerator < Rails::Generators::Base
  argument :model, type: :string

  def create_model_file
    create_file "app/models/#{model.singularize}.rb", <<-FILE
class #{model.singularize.classify} < SalesforceModel
  self.table_name = 'salesforce.#{model.singularize}'
end
    FILE
  end
end