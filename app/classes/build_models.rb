# frozen_string_literal: true

require "rails/generators"

class BuildModels
  attr_reader :max

  def initialize(max)
    @max = max
  end

  def call
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
    SetMappingsUsed.new(tables.count).call
  end

  private
    def tables
      @tables ||= determine_tables
    end

    def raise_no_tables_error
      raise "No Database tables found - please make sure to create at least one Mapping in Heroku Connect"
    end

    def determine_tables
      available_tables = DiscoverModels.new.new_tables
      count = available_tables.count
      raise_no_tables_error unless available_tables.any?

      prompt = TTY::Prompt.new
      selected_tables = []
      attempts = 0
      while selected_tables.count == 0
        attempts += 1
        puts "Please select at least one table" if attempts > 1
        selected_tables = prompt.multi_select(
          "Please select up to #{max} #{max > 1 ? 'objects' : 'object'} for your API",
          available_tables.map(&:name),
          max: max,
          per_page: 15,
          echo: false,
        )
      end
      selected_tables.map do |name|
        available_tables.detect { |t| t.name == name }
      end
    end
end
