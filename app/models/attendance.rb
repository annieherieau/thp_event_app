class Attendance < ApplicationRecord
  # table N-1
  belongs_to :user
  # table N-1
  belongs_to :event

  # Validations
  validates :user, uniqueness: { scope: :event }

end
