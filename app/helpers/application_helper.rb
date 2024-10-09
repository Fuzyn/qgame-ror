module ApplicationHelper
  def subclasses(source)
    eager_load_classes(source)
    ObjectSpace.each_object(Class).select { |klass| klass < self }.sort_by { |klass| klass.order }
  end

  def eager_load_classes(source)
    Dir[Rails.root.join("app/#{source}/*.rb")].each do |file|
      require_dependency file
    end
  end

  def basic_points
    self.try(:points)
  end

  def basic_key
    self.try(:key)
  end

  def basic_name
    self.try(:name)
  end

  def basic_description
    self.try(:description)
  end

  def basic_img
    self.try(:img)
  end

  def default_relation_name
    self.relation_name || self.superclass.relation_name
  end

  def default_source
    self.try(:source)
  end

  def class_order
    self.try(:order)
  end
end
