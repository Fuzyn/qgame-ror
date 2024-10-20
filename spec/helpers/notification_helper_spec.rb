require 'rails_helper'

RSpec.describe NotificationHelper, type: :helper do
  let(:user) { create(:user) }
  let(:title) { "Test Message" }
  let(:message_content) { "This is a test message." }
  let(:message_type) { UserMessage::INITIAL_KEY }

  describe 'create_message' do
    it 'creates a UserMessage with the given attributes' do
      user_message = create_message(user, title, message_content, message_type)

      expect(user_message.user).to eq(user)
      expect(user_message.title).to eq(title)
      expect(user_message.message).to eq(message_content)
      expect(user_message.message_type).to eq(message_type)
    end
  end
end
