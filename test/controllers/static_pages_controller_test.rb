require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get instructions" do
    get static_pages_instructions_url
    assert_response :success
  end

end
