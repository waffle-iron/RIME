require 'test_helper'

class ChatRoomsControllerTest < ActionDispatch::IntegrationTest

  test "should get new" do
    get new_chat_room_url
    assert_response :success
  end

  test "should get index" do
    get chat_rooms_url
    assert_response :success
  end

end
