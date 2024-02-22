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
  def new_attendance_email(user, event_id)
    @user = user
    @event = Event.find(event_id)
    @url = default_url_options
    @url_event = event_url(event_id)
    mail(to: @user.email, subject: 'Thp Event App : inscription à un évènement') 
  end
end
