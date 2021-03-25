class MessagesController < ApplicationController

  def index
    @messages = Message.all
    render json: @messages
  end

  def create
    @message = Message.create(message_params)
    render json: @message
  end

  def farts
    @message = Channel.find(2).messages.create(content: "Farts", user: User.find(2))
    puts @message.errors.full_messages.to_sentence
    ChannelChannel.broadcast_to(@message.channel, @message)
  end

  private

  def message_params
    params.permit(:username, :content, :channel_id)
  end

end
