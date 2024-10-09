# frozen_string_literal: true

module DevelopmentHelper
  include ApplicationHelper

  def calculated_degree(planet)
    level = planet.send(default_relation_name)[self.basic_key]
    level > 0 ? self.degree_growth ** level : 0
  end

  def planet_development_sum_points(planet)
    self.subclasses(default_source).map { |e| e.basic_points * e.calculated_degree(planet) }.sum.to_i
  end
end
