require 'rails_helper'

RSpec.describe Assignment, type: :model do
  describe 'validations' do
  end

  describe 'associations' do
    it { should belong_to :user }
    it { should belong_to :task }
  end
end
