class UserMailer < ApplicationMailer
  default from: ENV['MAILJET_DEFAULT_FROM']

  # email envoyé lors de l'inscription d'un nouvel utilisateur
  def welcome_email(user)
    @user = user 
    @url = default_url_options
    @url_sign_in = new_user_session_url
    mail(to: @user.email, subject: 'Bienvenue sur Thp Event App !') 
  end

    # email envoyé lors de l'inscription à un évènement
    def new_attendance_email(attendance)
      @user = attendance.user
      @event = attendance.event
      @url = default_url_options
      @url_event = event_url(@event.id)
      mail(to: @user.email, subject: 'Thp Event App : inscription à un évènement') 
    end
  
    # email envoyé lors de la désinscription à un évènement
    def delete_attendance_email(attendance)
      @user = attendance.user
      @event = attendance.event
      @url = default_url_options
      @url_event = event_url(@event.id)
      mail(to: @user.email, subject: 'Thp Event App : désinscription à un évènement') 
    end
end
