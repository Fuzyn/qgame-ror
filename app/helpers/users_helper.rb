module UsersHelper
  extend ApplicationHelper

  def user_sum_points
    self.planets.map { |e| e.planet_sum_points}.sum
  end
end
