# frozen_string_literal: true

module DevelopmentHelper
  include ApplicationHelper

  def calculated_degree(user)
    level = user.send(default_relation_name)[self.basic_key]
    level > 0 ? self.degree_growth ** level : 0
  end

  def user_development_sum_points(user)
    self.subclasses(default_source).map { |e| e.basic_points * e.calculated_degree(user) }.sum.to_i
  end
end
