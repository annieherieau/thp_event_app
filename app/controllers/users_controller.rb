class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    redirect_to root_path if current_user.id != params[:id].to_i
    @user = User.find(params[:id])
    @admin_events = Event.where(admin_user_id: @user.id)
    @user.admin_events
    @events = @user.events
  end
end
