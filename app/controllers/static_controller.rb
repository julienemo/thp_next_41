class StaticController < ApplicationController
  include UsersHelper
  before_action :private_route, only: [:profile]
  
  def home; end

  def profile
    @user = current_user
    @display_name = display_name(@user)
  end
end
