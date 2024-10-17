module NotificationHelper
  def create_log(user, message)
    SendLogWorkerJob.perform_later(message, user)
  end

  def create_message(user, title, message, message_type)
    UserMessage.create!(
      {
        user: user,
        title: title,
        message: message,
        message_type: message_type
      }
    )
  end
end
