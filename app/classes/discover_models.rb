# frozen_string_literal: true

class DiscoverModels
  def initialize; end

  def all_tables
    schema.tables
  end

  def new_tables
    all_tables.reject do |table|
      next true if table.name[0] == "_"
      next true if table.name == "versions"      
      model_name = table.name.remove("__c").classify
      klass_defined?(model_name)
    end
  end
 
  private
    def schema_data    
      File.open(schema_path, "r") { |f| f.read }
    end

    def schema_path
      "#{Rails.root.to_s}/db/schema.rb"
    end

    def klass_defined?(klass_name)
      klass_name.constantize
      return true
    rescue
      return false
    end

    def schema
      @schema ||= SchemaToScaffold::Schema.new(schema_data)
    end
end