class AttendancesController < ApplicationController
  before_action :authenticate_user!

  def create(user_id = params['user_id'], event_id = params['event_id'])
    @user = User.find(user_id)
    @event = Event.find(event_id)
    @attendance = Attendance.new(
      user_id: @user.id,
      event_id: @event.id
    )
    if @attendance.save
      redirect_to request.referrer if @event.price.zero?
    else
      flash[:alert] = "Un problème est survenu, merci de contacter l'administrateur" unless @event.price.zero?
    end
  end

  def destroy
    @attendance = Attendance.where(user_id: params[:user_id] , event_id: params[:id])
    @attendance.first.destroy
    redirect_to request.referrer
  end
  
end
