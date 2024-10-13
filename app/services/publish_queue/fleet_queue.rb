# frozen_string_literal: true

module PublishQueue
  class FleetQueue
    ROUTING_KEY = 'qgame_app.fleet_build'.freeze
    EXCHANGE_NAME = 'qgame_app'.freeze

    def initialize(data:)
      @data = data
    end

    def add_assignment
      PublishQueue::Application.new(
        routing_key: ROUTING_KEY,
        exchange_name: EXCHANGE_NAME,
        data: @data
      ).perform
    end
  end
end
