class ChannelChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "channel_channel"
    # stream_from "some_channel"
    @channel = Channel.find(params[:id])
    puts "streaming for #{@channel.id}"
    # puts "I am #{self}"
    stream_for @channel
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
