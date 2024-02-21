class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id].to_i)
    @users = @event.user_ids
    @admin_user = @event.admin_user
  end

  def new
    @event = Event.new
    @event.duration = 60
  end

  def create
    @event = Event.new(post_params)

    if @event.save
      redirect_to event_path(@event)
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id].to_i)
    redirect_to event_path(@event) if current_user.id != @event.admin_user_id
  end

  def update
    @event = Event.find(params[:id].to_i)
    if @event.update(post_params)
      redirect_to event_path(@event)
    else
      render :edit
    end
  end

  def destroy
  end


  private
  def post_params
    post_params = params.require(:event).permit(:admin_user_id, :start_date, :title, :duration, :price, :description, :location)
  end
end
