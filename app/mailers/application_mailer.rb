class ApplicationMailer < ActionMailer::Base
  default from: ENV['MAILJET.DEFAULT_FROM']
  layout "mailer"
end
