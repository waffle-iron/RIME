class ChatRoomsController < ApplicationController
  def new
    @chat = ChatRoom.new
  end

  def index
    @chat = ChatRoom.all
  end

  def create
    @chat = current_user.channels.build(chat_room_params)

    if @channel.save
      flash[:success] = "Room Created!"
      redirect_to chat_rooms_path

    else
      render 'new'
    end
  end

  def showChat
    @chat_room = ChatRoom.includes(:messages).find_by(id: params[:id])
  end

  private
    def chat_room_params
      params.require(:chat_room).permit(:name)
    end
end
