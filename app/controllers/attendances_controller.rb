class AttendancesController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params['user_id'])
    @attendance = Attendance.new(
      user_id: @user.id,
      event_id: params['event_id']
    )
    if @attendance.save
      @user.new_attendance_send(@event_id)
      render event_path(@event_id)
    else
      flash[:alert] = "Un problème est survenu, merci de contacter l'administrateur"
    end
  end

  
end
