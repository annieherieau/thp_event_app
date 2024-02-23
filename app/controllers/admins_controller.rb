class AdminsController < ApplicationController
  before_action :authenticate_admin!
  

  # DASHBOARD
  def index
    @events_to_review = Event.where(reviewed: false)
    @validated_events = Event.where(validated: true)
    @rejected_events = Event.where(validated: false)
  end

  # Profil
  def show
    @admin = Admin.find(params[:id])
    redirect_to root_path if current_admin != @admin
  end
end
