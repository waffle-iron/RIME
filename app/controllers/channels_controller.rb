class ChannelsController < ApplicationController
  def new
    @channel = Channel.new
  end

  def index
    @channels = Channel.all
  end

  def create
    @channel = current_user.channels.build(channel_params)

    if @channel.save
      flash[:success] = "Channel Created!"
      redirect_to channels_path

    else
      render 'new'
    end
  end

  private
    def channel_params
      params.require(:channel).permit(:name)
    end
end
