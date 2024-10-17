class UserMessage < ApplicationRecord
  belongs_to :user

  INITIAL_KEY = "initial".freeze
  TRANSPORT_KEY = "transport".freeze
  ATTACK_KEY = "attack".freeze
  SPY_KEY = "spy".freeze
  EXPEDITION_KEY = "expedition".freeze
  COLONIZE_KEY = "colonize".freeze

  INITIAL_TITLE = "Initial".freeze
  TRANSPORT_TITLE = "Transport".freeze
  ATTACK_TITLE = "Attack".freeze
  SPY_TITLE = "Spy".freeze
  EXPEDITION_TITLE = "Expedition".freeze
  COLONIZE_TITLE = "Colonize".freeze

  scope :unread, -> { where(read_date: nil) }
  scope :initial_type, -> { where(message_type: INITIAL_KEY) }
  scope :transport_type, -> { where(message_type: TRANSPORT_KEY) }
  scope :attack_type, -> { where(message_type: ATTACK_KEY) }
  scope :spy_type, -> { where(message_type: SPY_KEY) }
  scope :expedition_type, -> { where(message_type: EXPEDITION_KEY) }
  scope :colonize_type, -> { where(message_type: COLONIZE_KEY) }

  after_create_commit { broadcast_append_to "unread_messages_#{user.id}", locals: { user_message: self, total_messages: user.user_messages.unread.size } }
  after_update_commit { broadcast_action }
  after_create_commit :remove_previous_message

  private

  def broadcast_action
    if read_date
      broadcast_remove_to "unread_messages_#{user.id}"
    else
      broadcast_replace_to "unread_messages_#{user.id}", locals: { user_message: self, total_messages: user.user_messages.unread.size }
    end
  end

  def remove_previous_message
    previous_message = user.user_messages.unread.order(created_at: :desc).second
    previous_message&.broadcast_remove_to "unread_messages_#{user.id}"
  end
end
