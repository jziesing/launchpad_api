require 'rails/generators'

class BuildModels
  def initialize;end

  def call
    tables = DiscoverModels.new.new_tables
    tables.each do |table|
      script = table.to_script('scaffold', false)
      script.pop
      final_script = script.join
      # exec(final_script)
      puts final_script
    end
  end
end