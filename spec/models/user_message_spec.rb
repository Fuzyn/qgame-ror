require 'rails_helper'

RSpec.describe UserMessage, type: :model do
  let(:user) { create(:user) }
  subject { build(:user_message, user: user) }

  it { should belong_to(:user) }

  describe 'scopes' do
    let!(:initial_message) { create(:user_message, :initial, user: user) }
    let!(:transport_message) { create(:user_message, :transport, user: user) }
    let!(:attack_message) { create(:user_message, :attack, user: user) }
    let!(:spy_message) { create(:user_message, :spy, user: user) }
    let!(:expedition_message) { create(:user_message, :expedition, user: user) }
    let!(:colonize_message) { create(:user_message, :colonize, user: user) }
    let!(:unread_message) { create(:user_message, user: user, read_date: nil) }
    let!(:read_message) { create(:user_message, user: user, read_date: Time.now) }

    it 'returns unread messages' do
      expect(UserMessage.unread).to include(unread_message)
      expect(UserMessage.unread).to all(have_attributes(read_date: nil))
      expect(UserMessage.unread).not_to include(read_message)
    end

    it 'returns messages with initial type' do
      expect(UserMessage.initial_type).to include(initial_message)
      expect(UserMessage.initial_type).to all(have_attributes(message_type: UserMessage::INITIAL_KEY))
      expect(UserMessage.initial_type).not_to include(transport_message, attack_message, spy_message, expedition_message, colonize_message)
    end

    it 'returns messages with transport type' do
      expect(UserMessage.transport_type).to include(transport_message)
      expect(UserMessage.transport_type).to all(have_attributes(message_type: UserMessage::TRANSPORT_KEY))
      expect(UserMessage.transport_type).not_to include(initial_message, attack_message, spy_message, expedition_message, colonize_message)
    end

    it 'returns messages with attack type' do
      expect(UserMessage.attack_type).to include(attack_message)
      expect(UserMessage.attack_type).to all(have_attributes(message_type: UserMessage::ATTACK_KEY))
      expect(UserMessage.attack_type).not_to include(initial_message, transport_message, spy_message, expedition_message, colonize_message)
    end

    it 'returns messages with spy type' do
      expect(UserMessage.spy_type).to include(spy_message)
      expect(UserMessage.spy_type).to all(have_attributes(message_type: UserMessage::SPY_KEY))
      expect(UserMessage.spy_type).not_to include(initial_message, transport_message, attack_message, expedition_message, colonize_message)
    end

    it 'returns messages with expedition type' do
      expect(UserMessage.expedition_type).to include(expedition_message)
      expect(UserMessage.expedition_type).to all(have_attributes(message_type: UserMessage::EXPEDITION_KEY))
      expect(UserMessage.expedition_type).not_to include(initial_message, transport_message, attack_message, spy_message, colonize_message)
    end

    it 'returns messages with colonize type' do
      expect(UserMessage.colonize_type).to include(colonize_message)
      expect(UserMessage.colonize_type).to all(have_attributes(message_type: UserMessage::COLONIZE_KEY))
      expect(UserMessage.colonize_type).not_to include(initial_message, transport_message, attack_message, spy_message, expedition_message)
    end
  end
end
