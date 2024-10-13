# frozen_string_literal: true
require 'bunny'

module PublishQueue
  class Application
    def initialize(routing_key:, exchange_name:, data:)
      @routing_key = routing_key
      @exchange_name = exchange_name
      @data = data
    end

    def perform
      connection.start
      channel = connection.create_channel
      @exchange = channel.direct(@exchange_name)
      @exchange.publish(@data.to_json, routing_key: @routing_key)
      connection.close
    end

    private

    def connection
      @connection ||= Bunny.new(connection_options)
    end

    def connection_options
      {
        host: A9n.queue_host,
        port: A9n.queue_port,
        vhost: A9n.queue_vhost,
        username: A9n.queue_username,
        password: A9n.queue_password
      }
    end
  end
end
