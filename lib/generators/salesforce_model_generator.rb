# frozen_string_literal: true

class SalesforceModelGenerator < Rails::Generators::Base
  argument :model, type: :string
  argument :table, type: :string

  def create_model_file
    create_file "app/models/#{model.singularize.underscore}.rb", <<-FILE
class #{model.singularize.classify} < SalesforceModel
  self.table_name = 'salesforce.#{table.singularize}'
end
    FILE
  end
end