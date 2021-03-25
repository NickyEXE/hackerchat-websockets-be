class Message < ApplicationRecord
  belongs_to :user
  belongs_to :channel
  has_many :likes
  after_create :broadcast

  def username
    user.username
  end

  def broadcast
    ChannelChannel.broadcast_to(channel, MessageSerializer.new(self))
    puts "broadcasting!"
  end

  def username=(username)
    self.user = User.find_or_create_by(username: username)
  end

  def like_count
    likes.size
  end

end
