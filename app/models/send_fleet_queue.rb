class SendFleetQueue < ApplicationRecord
  belongs_to :user
  belongs_to :planet

  scope :active, -> { where(deleted: false) }

  after_create_commit { broadcast_append_to "sent_fleet_#{user.id}", locals: { sent_fleet_queue: self, path: '' } }
  after_update_commit { broadcast_action }

  private

  def broadcast_action
    if deleted
      broadcast_remove_to "sent_fleet_#{user.id}"
    else
      broadcast_replace_to "sent_fleet_#{user.id}", locals: { sent_fleet_queue: self, path: '' }
    end
  end
end
