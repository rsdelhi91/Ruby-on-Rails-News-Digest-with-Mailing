require 'test_helper'

class SessionControllerTest < ActionController::TestCase
  test 'should get login' do
    get :login
    assert_response :success
  end

  test 'should get logout' do
    get :logout
    assert_response :success
  end

  test 'should get check_params' do
    get :check_params
    assert_response :success
  end
end
