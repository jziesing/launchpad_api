class ShowAction < SweetActions::JSON::ShowAction
  # def set_resource
  #   resource_class.find(params[:id])
  # end

  def authorized?
    controller.can(:read, resource)
  end
end
