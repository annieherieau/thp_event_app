class EventSubmissionsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @events = Event.all_to_review
  end

  def show
    @event = Event.find(params[:id].to_i)
    @users = @event.user_ids
    @admin_user = @event.admin_user
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(post_params)
      redirect_to event_path(@event)
    else
      render :edit
    end
  end

  private
  def post_params
    post_params = params.require(:event).permit(:validated, :reviewed)
  end
end
