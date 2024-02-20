class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
    @event.duration = 60
  end

  def create
    @event = Event.new(
      admin_user_id: params[:admin_user_id].to_i,
      title: params[:title],
      start_date: DateTime.new(params["[start_date(1i)]"].to_i, 
      params["[start_date(2i)]"].to_i, params["[start_date(3i)]"].to_i, 
        params["[start_date(4i)]"].to_i, params["[start_date(5i)]"].to_i),
      duration: params[:duration],
      price: params[:price],
      location: params[:location],
      description: params[:description],
    )

    if @event.save
      redirect_to events_path(@event)
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def destroy
  end


  private
  def post_params
    post_params = params.require(:event).permit(:admin_user_id, :start_date, :title, :duration, :price, :description, :location)
  end
end
