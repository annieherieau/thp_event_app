class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #Table 1-N
  has_many :admin_events, foreign_key: 'admin_event_id', class_name: 'Event'
  
  #table N-N through
  has_many :attendances
  has_many :events, through: :attendances

  # validation
  validates :first_name, :last_name, presence: true
  validates :email, presence: true , uniqueness: true, confirmation: true

  # callbacks
  after_create :welcome_send

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  def new_attendance_send(event_id)
    UserMailer.new_attendance_email(self, event_id).deliver_now
  end
end
