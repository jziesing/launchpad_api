# frozen_string_literal: true

class ApiControllerGenerator < Rails::Generators::Base
  argument :model, type: :string

  def create_model_file
    create_file "app/controllers/api/#{collection_name}_controller.rb", <<-FILE
class Api::#{model_name.pluralize}Controller < ApiController
  def index
    @#{collection_name} = paginate #{model_name}.all
    authorize!(:read, @#{collection_name})
    json_with @#{collection_name}    
  end

  def show
    @#{individual_name} = #{model_name}.find(params[:id])
    authorize!(:read, @#{individual_name})
    json_with @#{individual_name}
  end

  def create
    @#{individual_name} = #{model_name}.new(#{individual_name}_params)
    authorize!(:create, @#{individual_name})
    @#{individual_name}.save ? create_success : create_failure
  end

  def update
    @#{individual_name} = #{model_name}.find(params[:id])
    authorize!(:update, @#{individual_name})
    @#{individual_name}.attributes = #{individual_name}_params
    @#{individual_name}.save ? update_success : update_failure
  end

  def destroy
    @#{individual_name} = #{model_name}.find(params[:id])
    authorize!(:destroy, @#{individual_name})
    @#{individual_name}.destroy
    json_with @#{individual_name}
  end

  private

  def #{individual_name}_params
    #{model_name}Decanter.decant(params[:#{individual_name}])
  end

  def create_success
    json_with @#{individual_name}
  end

  def create_failure
    json_with @#{individual_name}
  end

  def update_success
    json_with @#{individual_name}
  end

  def update_failure
    json_with @#{individual_name}
  end  
end
    FILE
  end

  def individual_name
    model.singularize.underscore
  end

  def collection_name
    model.pluralize.underscore
  end

  def model_name
    model.classify
  end
end