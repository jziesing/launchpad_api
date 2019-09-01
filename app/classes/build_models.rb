require 'rails/generators'

class BuildModels
  {
    'timestamp without time zone' => 'datetime',
    'timestamp without time zone' => 'datetime',
  }
  [, "boolean", "character varying", "timestamp without time zone", "character varying", "integer", "character varying", "text"]
  def initialize;end

  def call
    connection = PG.connect('postgres://pcqlgrquymfezx:74ef9d3d6f3feb0cdd05774ac7f30c95787c5e901ccd9007f7b73d3606f969b8@ec2-54-83-9-36.compute-1.amazonaws.com:5432/d2120cqo8q9ooe') 
    tables = connection.exec("SELECT table_name FROM information_schema.tables WHERE table_schema='salesforce'").map do |result|
      table_name = result['table_name']
      next if table_name[0] == '_'
      table_name
    end.compact
    tables.each do |table|
      query = "SELECT *
              FROM information_schema.columns
              WHERE table_schema = 'salesforce'
              AND table_name   = '#{table}'
              ;"      
      connection.exec(query) do |columns|
        columns.map do |column|
          name = column['column_name']
          data_type = column['data_type']
          # "#{}
          # cols.delete('id')  
          binding.pry
        end              
      end
      
      exec("rails g model #{table.classify}")
      # Rails::Generators.invoke('model', [table.classify])
    end
  end
end