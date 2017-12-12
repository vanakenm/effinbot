require 'test_helper'

class CommandsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get commands_create_url
    assert_response :success
  end

end
