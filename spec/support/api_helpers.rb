module ApiHelpers
  def attribute_to_use(model_class, permitted_params)
    model_class.columns.detect do |column|
      column.type == :string && permitted_params.include?(column.name.to_sym)
    end
  end

  def put_params(model_class, permitted_params)
    column = attribute_to_use(model_class, permitted_params)
    value = [model_class.first.try(:send, column.name), 'New Value'].join(' - ')
    { column.name => value }
  end

  def post_params(model_class, permitted_params)
    column = attribute_to_use(model_class, permitted_params)
    { column.name => "My Newly Created #{model_class.name.titleize}" }
  end  
end