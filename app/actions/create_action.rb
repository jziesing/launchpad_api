class CreateAction < SweetActions::JSON::CreateAction
  # def set_resource
  #   resource_class.new(resource_params)
  # end

  def authorized?
    controller.can(:create, resource)
  end

  # def save
  #   resource.save
  # end
end
