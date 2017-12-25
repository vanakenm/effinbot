require 'test_helper'

class EffinQuotesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get effin_quotes_index_url
    assert_response :success
  end

  test 'should get show' do
    get effin_quotes_show_url
    assert_response :success
  end

  test 'should get find' do
    get effin_quotes_find_url
    assert_response :success
  end
end
