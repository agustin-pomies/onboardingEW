require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:completed) }
  end

  describe 'associations' do
    it { should have_many :assignments }
    it { should have_many :users }
  end
end
