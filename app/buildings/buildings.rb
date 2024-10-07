# frozen_string_literal: true

class Buildings
  def self.subclasses
    eager_load_fleet_classes
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end

  def self.eager_load_fleet_classes
    Dir[Rails.root.join('app/buildings/*.rb')].each do |file|
      require_dependency file
    end
  end

  def self.user_values(user)
    self.subclasses.map do |e|
      {
        extraction: e.extraction(user),
        energy_consumption: e.energy(user),
        key: e.basic_key,
        name: e.basic_name,
        description: e.basic_description,
        img: e.basic_img,
        level: user.user_building[e.basic_key]
      }
    end
  end

  def self.extraction(user)
    (self.basic_extraction + (self.basic_extraction * calculated_degree(user))).to_i
  end

  def self.energy(user)
    (self.energy_consumption - (self.energy_consumption * calculated_degree(user))).to_i
  end

  def self.calculated_degree(user)
    self.degree_growth * user.user_building[self.basic_key]
  end

  def self.basic_key
    self.key
  end

  def self.basic_name
    self.name
  end

  def self.basic_description
    self.description
  end

  def self.basic_img
    self.img
  end
end
