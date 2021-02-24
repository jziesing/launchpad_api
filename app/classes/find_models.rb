class FindModels
  def initialize;end
  
  def folder
    # iterate over all files in folder
    File.join(Rails.root, "app", "models", "salesforce")
  end

  def models
    Dir[File.join(folder, "*")].map do |filename|
      "Salesforce::#{File.basename(filename, '.rb').camelize}".constantize
    end    
  end

  def plural_names
    Dir[File.join(folder, "*")].map do |filename|
      File.basename(filename, '.rb').pluralize
      "#{File.basename(filename, '.rb').pluralize}"
    end
  end
end