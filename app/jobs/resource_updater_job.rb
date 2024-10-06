class ResourceUpdaterJob
  include Sidekiq::Job

  def perform
    User.all.each do |user|
      user.increment_resources
    end
  end
end