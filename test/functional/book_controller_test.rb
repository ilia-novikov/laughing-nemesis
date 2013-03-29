require 'test_helper'

class BookControllerTest < ActionController::TestCase
  test "should get find" do
    get :find
    assert_response :success
  end

  test "should get info" do
    get :info
    assert_response :success
  end

end
