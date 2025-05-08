require "test_helper"

class CardDrawControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get card_draw_index_url
    assert_response :success
  end
end
