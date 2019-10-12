class Api::AccountsController < ApplicationController
  def index
    @accounts = Account.all.limit(50)
    authorize!(:read, @accounts)
    json_with @accounts    
  end

  def show
    @account = Account.find(params[:id])
    authorize!(:read, @account)
    json_with @account
  end

  def create
    @account = Account.new(account_params)
    authorize!(:create, @account)
    @account.save ? create_success : create_failure
  end

  def update
    @account = Account.find(params[:id])
    authorize!(:update, @account)
    @account.attributes = account_params
    @account.save ? update_success : update_failure
  end

  def destroy
    @account = Account.find(params[:id])
    authorize!(:destroy, @account)
    @account.destroy
    json_with @account
  end

  private

  def account_params
    AccountDecanter.decant(params[:account])
  end

  def create_success
    json_with @account
  end

  def create_failure
    json_with @account
  end

  def update_success
    json_with @account
  end

  def update_failure
    json_with @account
  end  
end
