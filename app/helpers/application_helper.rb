module ApplicationHelper
  def subclasses(source)
    eager_load_classes(source)
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end

  def eager_load_classes(source)
    Dir[Rails.root.join("app/#{source}/*.rb")].each do |file|
      require_dependency file
    end
  end

  def basic_points
    self.points
  end

  def basic_key
    self.key
  end

  def basic_name
    self.name
  end

  def basic_description
    self.description
  end

  def basic_img
    self.img
  end

  def default_relation_name
    self.relation_name || self.superclass.relation_name
  end

  def default_source
    self.source
  end
end
