class UsersChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'UsersChannel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
