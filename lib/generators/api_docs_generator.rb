class ApiDocsGenerator < Rails::Generators::Base
  argument :model, type: :string

  def create_model_file
    create_file "spec/acceptance/api/#{collection_name}_spec.rb", <<-FILE
require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource '#{model_name.pluralize}' do
  let(:token) { Base64.strict_encode64("launchpad:\#{ENV['LAUNCHPAD_LICENSE_KEY']}") }
    
  before do
    authentication :basic, "Basic \#{token}"
  end

  get '/api/#{collection_name}' do
    example 'Collection of #{model_name.pluralize}' do
      do_request

      expect(status).to eq 200
    end
  end

  get '/api/#{collection_name}/accounts/1' do
    example 'Find an Individual #{model_name}' do
      do_request

      expect(status).to eq 200
    end
  end

  put '/api/#{collection_name}/:id' do
    #{individual_name} = #{model_name}.first
    permitted_params = #{model_name}Decanter.handlers.map(&:first).map(&:first)
    let(:#{individual_name}_params) do
      key, value = #{model_name}.first.attributes.detect do |key, value|
        value.is_a?(String) && permitted_params.include?(key.to_sym)
      end
      { key => "#{value} (updated)" }
    end
    
    with_options scope: :#{individual_name} do
      permitted_params.each do |attr|
        parameter attr, example: #{individual_name}.send(attr)
      end
    end
    
    context "200" do
      let(:id) { 1 }
      example 'Update an Individual #{model_name}' do
        request = {
          #{individual_name}: #{individual_name}_params,
        }       
        do_request(request)
        expect(status).to eq 200
      end
    end
  end  
end

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