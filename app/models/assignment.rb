class Assignment < ApplicationRecord
  belongs_to :user
  belongs_to :task

  validates :ownership, inclusion: { in: [true, false] }
end
