class WelcomeController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user_name
  
  def index
  end
  
  private
  
  def get_user_name
    @user = current_user
  end
end
