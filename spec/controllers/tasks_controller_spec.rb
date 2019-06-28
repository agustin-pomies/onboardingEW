require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe "GET tasks#index" do
    context 'when user is logged in' do
      before do
        random_user = create(:random_user)
        sign_in random_user
        get :index
      end

      it { is_expected.to respond_with :ok }
      it { is_expected.to render_template :index }
    end

    context 'when user is logged out' do
      before do
        get :index
      end
      it { is_expected.to redirect_to new_user_session_path }
    end
  end

  describe 'GET tasks#new' do
  end

  describe 'GET task#show' do
    before do
      random_user = create(:random_user)
      task = create(:task)
      assignment = create(:assignment, user: random_user, task: task)

      random_user.assignments << [assignment]
      task.assignments << [assignment]

      sign_in random_user
      #visit "/task/" + (task.id)
    end

    it 'render tasks#show template' do
      page.should have_content(task.description)
    end
  end

  describe 'POST tasks#new' do
    context 'when attributes are valid' do
      it 'redirect to the task path on succesful save' do
      end
    end

    context 'when attributes are not valid' do
      it "render the new screen again with errors if the model doesn't save" do
      end
    end
  end

end
