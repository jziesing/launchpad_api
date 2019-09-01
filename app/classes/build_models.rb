require 'rails/generators'

class BuildModels
  def initialize;end

  def call
    tables = DiscoverModels.new.new_tables
    tables.each do |table|
      script = table.to_script('model', false)
      script.pop
      final_script = script.join
      puts final_script

      columns = table.attributes.map { |attr| attr.name }
      model_name = table.name.classify
      columns_string = columns.join(' ')
      puts "rails generate decanter #{model_name} #{columns_string}"
      puts "rails generate serializer #{model_name} #{columns_string}"
      puts "rails g actions #{model_name.pluralize}"
    end
  end
end