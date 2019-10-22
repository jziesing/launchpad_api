require 'rails/generators'

class BuildModels
  def initialize;end

  def call
    Rake::Task["db:schema:dump"].invoke
    tables = DiscoverModels.new.new_tables
    return unless tables.any?
    model_names = []
    tables.each do |table|
      columns = table.attributes.map { |attr| "#{attr.name}:#{attr.type}" }
      model_name = table.name.remove('__c').classify
      model_names << model_name
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
      system("rails g api_controller #{model_name}")
      system("rails g api_docs #{model_name}")
    end
    system("rails g routes #{model_names.join(' ')}")
    system('rake docs:generate')
  end
end