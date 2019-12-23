require 'test_helper'

class WebScrappersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get web_scrappers_index_url
    assert_response :success
  end

end
