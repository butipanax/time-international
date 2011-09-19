require 'test_helper'

class BusinessControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
