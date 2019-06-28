class Task < ApplicationRecord
  has_many :assignments, dependent: :destroy
  has_many :users, through: :assignments

  accepts_nested_attributes_for :assignments

  validates :description, presence: true
  validates :completed, inclusion: { in: [true, false] }
end
