require "test_helper"

class AuthControllerTest < ActionDispatch::IntegrationTest
  test "should get start" do
    get auth_start_url
    assert_response :success
  end

  test "should get verify" do
    get auth_verify_url
    assert_response :success
  end
end
