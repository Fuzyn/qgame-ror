# frozen_string_literal: true

class Technology
  extend DevelopmentHelper

  @relation_name = 'user_technology'.freeze
  @source = 'technology'.freeze

  class << self
    attr_accessor :relation_name
    attr_accessor :source
  end

  def self.user_values(user)
    self.subclasses(@source).map do |e|
      {
        points: e.basic_points,
        degree_growth: e.calculated_degree_growth(user),
        degree_drop: e.calculated_degree_drop(user),
        key: e.basic_key,
        name: e.basic_name,
        description: e.basic_description,
        img: e.basic_img,
        level: user.user_technology[e.basic_key],
        order: e.class_order
      }
    end
  end

  def self.calculated_degree_growth(user)
    result = super
    result > 0 ? result : 1
  end

  def self.calculated_degree_drop(user)
    result = super
    result > 0 ? result : 1
  end
end
