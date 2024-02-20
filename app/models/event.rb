class Event < ApplicationRecord
  #table N-1  Class_name
  belongs_to :admin_user, class_name: 'User'


  # validation
  validates_comparison_of :start_date, greater_than: DateTime.now, presence: true
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }, if: :is_multiple_of_5?
  validates :title, presence: true,  length: {minimum: 3, maximum:140}
  validates :description, presence: true, length: {minimum:20, maximum:1000}
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1000 }
  validates :location, presence: true

  private
  def is_multiple_of_5?
    if (duration % 5) > 0
      errors.add(:duration, "must be multiple of 5")
      return false
    end
  end

end
