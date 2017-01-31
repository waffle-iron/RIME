class RenameChannelsToChatRooms < ActiveRecord::Migration[5.0]
  def change
    rename_table :channels, :chat_rooms
  end
end
