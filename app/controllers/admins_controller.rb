class AdminsController < ApplicationController
  before_action :authenticate_admin!
  def show
    redirect_to root_path if current_admin.id != params[:id].to_i
  end
end
