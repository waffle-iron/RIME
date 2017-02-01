class ChatRoomsController < ApplicationController
  def new
    @chat = ChatRoom.new
  end

  def index

    if(@user = current_user)
      if(@chats = ChatRoom.find_by(user: @user))
          @chosen = ChatRoom.first

      else
        @chosen = nil
      end

    end

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

  def show

    if(@user = current_user)

      if(@chats = ChatRoom.find_by(user: @user))
          @chosen = ChatRoom.includes(:messages).find_by(id: params[:id])

      else
        @chosen = nil
      end

    end

  end

  private
    def chat_room_params
      params.require(:chat_room).permit(:name)
    end
end
