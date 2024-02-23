class Event < ApplicationRecord
  #table N-1  Class_name
  belongs_to :admin_user, class_name: 'User'

  # table N-N Class_name through
  has_many :attendances
  has_many :users, through: :attendances

  # validation
  validates_comparison_of :start_date, greater_than: DateTime.now, presence: true
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }, if: :is_multiple_of_5?
  validates :title, presence: true,  length: {minimum: 3, maximum:140}
  validates :description, presence: true, length: {minimum:20, maximum:1000}
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1000 }
  validates :location, presence: true

  def date
    self.start_date.strftime('%d/%m/%Y')
  end

  def duration_conversion
    hours = (duration / 60).to_s.rjust(2,'0')
    minutes = (duration % 60).to_s.rjust(2,'0')
    return "#{hours}:#{minutes}" 
  end

  def start_time
    self.start_date.strftime('%H:%M')
  end

  def end_time
    (self.start_date + duration*60).strftime('%H:%M')
  end

  def is_already_registred?(user)
    self.users.include?(user)
  end

  def is_admin?(user)
    self.admin_user == user
  end

  # statut: si validé : true, non validé : false, pas encore revu (draft) : nil
  def is_validated?
    return nil if self.validated.nil?
    self.validated
  end

  def status
    case self.is_validated?
    when true
      'accepté'
    when false
      'refusé'
    else
      'brouillon'
    end
  end

  # modifiable event non validé
  def is_editable?
    self.validated.nil? && self.start_date < DateTime.now
  end

  def self.all_validated
    self.all.where(validated: true)
  end

  private
  def is_multiple_of_5?
    if (duration % 5) > 0
      errors.add(:duration, "must be multiple of 5")
      return false
    end
  end

end
