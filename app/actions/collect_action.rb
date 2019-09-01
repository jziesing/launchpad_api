class CollectAction < SweetActions::JSON::CollectAction
  def set_resource
    resource_class.all.limit(50)
  end

  def authorized?
    false
  end
end
