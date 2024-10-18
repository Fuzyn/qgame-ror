# frozen_string_literal: true

module DevelopmentHelper
  include ApplicationHelper

  def calculated_degree_growth(source)
    calculated_degree(source, 'degree_growth')
  end

  def calculated_degree_drop(source)
    calculated_degree(source, 'degree_drop')
  end

  def development_sum_points(source)
    self.subclasses(default_source).map { |e| e.basic_points * e.calculated_degree_growth(source) }.sum.to_i
  end

  private

  def calculated_degree(source, key)
    level = source.send(default_relation_name)[self.basic_key]
    level && level > 0 ? (self.public_send(key) ** level).round(2) : 0
  end
end
