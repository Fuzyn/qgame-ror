class BuildQueue < ApplicationRecord
  belongs_to :user

  scope :defence, -> { where(source: 'planet_defence', deleted: false) }
  scope :fleet, -> { where(source: 'planet_fleet', deleted: false) }
  scope :building, -> { where(source: 'planet_building', deleted: false) }
  scope :technology, -> { where(source: 'user_technology', deleted: false) }

  def queue_values
    ObjectSpace.each_object(Class) do |klass|
      if klass.instance_variable_defined?(:@key) && klass.instance_variable_get(:@key) == self.key
        @class = klass
      end
    end
    {
      img: @class.basic_img,
      name: @class.basic_name,
      end_time: self.end_time
    }
  end
end
