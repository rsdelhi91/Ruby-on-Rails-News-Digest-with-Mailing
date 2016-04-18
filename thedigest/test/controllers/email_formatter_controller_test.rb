require 'test_helper'

class EmailFormatterControllerTest < ActionController::TestCase
  test 'should get matchNews' do
    get :matchNews
    assert_response :success
  end

  test 'should get generateMessage' do
    get :generateMessage
    assert_response :success
  end
end
