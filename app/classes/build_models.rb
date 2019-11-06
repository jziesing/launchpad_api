# frozen_string_literal: true

require "rails/generators"

class BuildModels
  attr_reader :num

  def initialize(num)
    @num = num
  end

  def call    
    tables = DiscoverModels.new.new_tables
    count = tables.count
    tables = tables[0..(num-1)]
    new_count = tables.count
    puts "We did not generate #{count - new_count} available objects as your plan only allows for #{num} Mapping" if new_count > count
    raise 'No Database tables found - please make sure to create at least one Mapping in Heroku Connect' unless tables.any?
    model_names = []
    tables.each do |table|
      columns = table.attributes.map { |attr| "#{attr.name}:#{attr.type}" }
      model_name = table.name.remove("__c").classify
      model_names << model_name
      columns_string = columns.join(" ")

      script = table.to_script("model", false)
      script.pop
      script << " --skip"
      script = script.join.split(" ")
      script[3] = model_name
      final_script = script.join(" ")
      
      system("rails generate salesforce_model #{model_name} #{table.name}")
      system(final_script)
      system("rails generate decanter #{model_name} #{columns_string}")
      system("rails generate serializer #{model_name} #{columns_string}")
      system("rails g api_controller #{model_name}")
      system("rails g api_docs #{model_name}")
    end
    system("rails g routes #{model_names.join(' ')}")
    system("rake docs:generate")
  end
end