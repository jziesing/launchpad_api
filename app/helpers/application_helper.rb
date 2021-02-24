module ApplicationHelper
  def plural_model_names
    FindModels.new.plural_names
  end

  def models
    FindModels.new.models
  end  
end
