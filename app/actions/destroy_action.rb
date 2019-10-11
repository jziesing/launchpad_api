class DestroyAction < SweetActions::JSON::DestroyAction
  # def set_resource
  #   resource_class.find(params[:id])
  # end

  def authorized?
    controller.can(:destroy, resource)
  end

  # def destroy
  #   resource.destroy
  # end
end
