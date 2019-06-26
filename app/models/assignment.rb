class Assignment < ApplicationRecord
  belongs_to :user
  belongs_to :task

  validates :ownership, presence: true
end
