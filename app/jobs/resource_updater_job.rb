class ResourceUpdaterJob
  include Sidekiq::Job

  def perform
    Planet.all.each do |planet|
      planet.increment_resources
    end
  end
end