# frozen_string_literal: true

class StorageTechnology < Technology
  @points = 400
  @degree_growth = 1.02
  @degree_drop = 1
  @order = 12
  @key = "storage_technology".freeze
  @name = "Storage Technology".freeze
  @description = "Storage Technology is a cutting-edge cosmic innovation designed to enhance the storage capacity of resources essential for space operations. By improving the efficiency and scale of resource containment, this technology allows for larger reserves of materials, ensuring sustainable development and expansion across the galaxy. It plays a critical role in supporting infrastructure, fleet operations, and planetary defense systems by maximizing the potential of available resources.".freeze
  @img = "technology/storage_technology.png".freeze

  class << self
    attr_accessor :points
    attr_accessor :degree_growth
    attr_accessor :degree_drop
    attr_accessor :order
    attr_accessor :key
    attr_accessor :name
    attr_accessor :description
    attr_accessor :img
  end
end
