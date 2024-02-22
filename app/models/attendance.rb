class Attendance < ApplicationRecord
  # table N-1
  belongs_to :user
  # table N-1
  belongs_to :event

  # Validations
  validates :user, uniqueness: { scope: :event }

  # callback
  after_create :new_send
  after_destroy :delete_send

  # à l'inscription evenement
  def new_send
    UserMailer.new_attendance_email(self).deliver_now
  end

  # à la désinscription evenement
  def delete_send
    UserMailer.delete_attendance_email(self).deliver_now
  end

end
