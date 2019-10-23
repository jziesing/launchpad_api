class ApiDocsGenerator < Rails::Generators::Base
  argument :model, type: :string

  def create_model_file
    create_file "spec/acceptance/api/#{collection_name}_spec.rb", <<-FILE
require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource '#{model_name.pluralize}' do
  let(:token) { Base64.strict_encode64("launchpad:\#{ENV['LAUNCHPAD_LICENSE_KEY']}") }
  permitted_params = #{model_name}Decanter.handlers.map(&:first).map(&:first)
    
  before do
    authentication :basic, "Basic \#{token}"
    header 'Content-Type', 'application/json'
  end

  get '/api/#{collection_name}' do
    example 'Get #{model_name.pluralize}' do
      do_request

      expect(response_status).to eq 200
    end
  end

  get '/api/#{collection_name}/:id' do
    let(:id) { 1 }
    example 'Find #{model_name}' do
      do_request

      expect(response_status).to eq 200
    end
  end

  put '/api/#{collection_name}/:id' do
    with_options scope: :#{individual_name} do
      permitted_params.each do |attr|
        parameter attr
      end
    end
    
    context '200' do
      let(:id) { 1 }
      example 'Update #{model_name}' do
        request = {
          #{individual_name}: put_params(#{model_name}, permitted_params),
        }       
        do_request(request)
        expect(response_status).to eq 200
      end
    end
  end  

  post '/api/#{collection_name}' do
    with_options scope: :#{individual_name} do
      permitted_params.each do |attr|
        parameter attr
      end
    end
    
    context '200' do
      example 'Create #{model_name}' do
        request = {
          #{individual_name}: post_params(#{model_name}, permitted_params),
        }       
        do_request(request)
        expect(response_status).to eq 200
      end
    end
  end
  
  delete '/api/#{collection_name}/:id' do
    context '200' do
      let(:id) { 1 }
      example 'Delete #{model_name}' do        
        do_request
        expect(response_status).to eq 200
      end
    end
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