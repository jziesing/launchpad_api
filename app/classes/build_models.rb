require 'rails/generators'

class BuildModels
  def initialize;end

  def call
    tables = DiscoverModels.new.new_tables
    
    tables.each do |table|
      columns = table.attributes.map { |attr| attr.name }
      model_name = table.name.remove('__c').classify
      columns_string = columns.join(' ')

      script = table.to_script('model', false)
      script.pop
      script << ' --skip'
      script = script.join.split(' ')
      script[3] = model_name
      final_script = script.join(' ')
      
      system("rails generate salesforce_model #{model_name} #{table.name}")
      system(final_script)
      system("rails generate decanter #{model_name} #{columns_string}")
      system("rails generate serializer #{model_name} #{columns_string}")
      system("rails g actions #{model_name.pluralize}")   
    end
  end
end