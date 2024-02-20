class User < ApplicationRecord
  #Table 1-N
  has_many :admin_events, foreign_key: 'admin_event_id', class_name: 'Event'
  
  #table N-N through
  has_many :attendances
  has_many :events, through: :attendances

  # validation
  validates :first_name, :last_name, presence: true

  # callbacks
  after_create :welcome_send

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
end
