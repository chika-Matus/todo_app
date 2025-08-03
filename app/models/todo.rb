class Todo < ApplicationRecord
  validates :title, presence: true, length: { minimum: 1, maximum: 100 }
  
  scope :completed, -> { where(completed: true) }
  scope :pending, -> { where(completed: false) }
  
  def toggle_completed!
    update!(completed: !completed)
  end
end