require 'rails_helper'

RSpec.describe TasksController, type: :controller do

  describe "GET #index" do
    context 'when user is logged in' do
      before do
        random_user = create(:random_user)
        sign_in random_user
        get :index
      end
      it { is_expected.to respond_with :ok }
    end

    context 'when user is logged out' do
      before do
        get :index
      end
      it { is_expected.to redirect_to new_user_session_path }
    end
  end

end
