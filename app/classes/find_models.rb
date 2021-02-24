class FindModels
  def initialize;end
  def call
    # iterate over all files in folder
    folder = File.join(RAILS_ROOT, "app", "models", "salesforce")      
    Dir[File.join(folder, "*")].map do |filename|
      File.basename(filename, '.rb').pluralize
    end
  end
end