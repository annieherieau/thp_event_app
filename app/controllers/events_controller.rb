class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @events = Event.all_validated
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
    # if current_user.id != @event.admin_user_id || !@event.is_editable?
    #   redirect_to event_path(@event)
    #   flash[:alert] = "Vous ne pouvez pas modifier cet évenement"
    # end
     
    
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
    # detruire les participant + mail d'annulation 
  end

  private
  def post_params
    post_params = params.require(:event).permit(:admin_user_id, :start_date, :title, :duration, :price, :description, :location)
  end
end
