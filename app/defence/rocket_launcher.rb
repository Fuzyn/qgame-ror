# frozen_string_literal: true

class RocketLauncher < Defence
  @points = 1000
  @shield = 300
  @attack = 100
  @order = 1
  @key = "rocket_launcher".freeze
  @name = "Rocket Launcher".freeze
  @description = "Rocket launchers are powerful weapons systems designed to launch long-range missiles capable of destroying enemy units in space. Thanks to advanced guidance technology, these rockets can target spacecraft with high precision, even at high speeds. They offer flexibility in the selection of explosive charges, which makes them an effective tool both for attacking large units and for eliminating smaller targets.".freeze
  @img = "defence/rocket_launcher.png".freeze

  class << self
    attr_accessor :points
    attr_accessor :shield
    attr_accessor :attack
    attr_accessor :order
    attr_accessor :key
    attr_accessor :name
    attr_accessor :description
    attr_accessor :img
  end
end
