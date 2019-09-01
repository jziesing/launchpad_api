require 'rails/generators'

class BuildModels
  def initialize;end

  def call
    tables = DiscoverModels.new.new_tables
    tables.each do |table|
      script = table.to_script('model', false)
      script.pop
      final_script = script.join
      system(final_script)

      columns = table.attributes.map { |attr| attr.name }
      model_name = table.name.classify
      columns_string = columns.join(' ')
      system("rails generate decanter #{model_name} #{columns_string}")
      system("rails generate serializer #{model_name} #{columns_string}")
      system("rails g actions #{model_name.pluralize}")
      
    end
  end
end