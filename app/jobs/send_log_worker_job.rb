class SendLogWorkerJob < ApplicationJob
  queue_as :default

  def perform(log_message, user)
    HTTParty.post('http://localhost:3001/logs', body: { message: log_message, user_email: user&.email, user_id: user&.id })
  end
end
