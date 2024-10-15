# frozen_string_literal: true

class FleetWorker
  include Sidekiq::Worker
  include FleetWorkerHelper

  def perform(record_id)
    record = SendFleetQueue.find(record_id)
    execute_sent_fleet(record)
  end
end
