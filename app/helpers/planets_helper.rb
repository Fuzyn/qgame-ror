module PlanetsHelper
  extend ApplicationHelper

  def planet_sum_points
    Fleet.planet_equipment_sum_points(self) +
      Defence.planet_equipment_sum_points(self) +
      Buildings.planet_development_sum_points(self)
  end

  def planet_energy_balance
    PowerStation.production(self) +
      MetalMine.energy(self) +
      CrystalMine.energy(self) +
      DeuteriumRefinery.energy(self)
  end

  def randomize_photo_number(user)
    photo_number = 1

    loop do
      photo_number = rand(1..4)
      break unless user.planets.where(photo_number: photo_number).present?
    end

    photo_number
  end

  def create_random_planet(user)
    galaxy = 1
    solar_system = 1
    planet_position = 1

    loop do
      galaxy = rand(1..9)
      solar_system = rand(1..255)
      planet_position = rand(1..15)

      break unless Planet.where(galaxy: galaxy, solar_system: solar_system, planet_position: planet_position).present?
    end

    user.planets.create!(
      {
        name: Faker::Lorem.word&.capitalize,
        galaxy: galaxy,
        solar_system: solar_system,
        planet_position: planet_position,
        photo_number: randomize_photo_number(user)
      })
  end

  def create_specific_planet(user, params)
    user.planets.create!(
      {
        name: Faker::Lorem.word&.capitalize,
        photo_number: randomize_photo_number(user),
        **params
      })
  end
end
