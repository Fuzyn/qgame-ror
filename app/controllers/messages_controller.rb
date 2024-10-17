class MessagesController < ApplicationController
  before_action :set_message, only: [:mark_as_read]

  def index
    @user = current_user
  end

  def mark_as_read
    if @message.read_date.nil?
      @message.update(read_date: Time.current)
    end
  end

  private

  def set_message
    @message = current_user.user_messages.find(params[:id])
  end
end
