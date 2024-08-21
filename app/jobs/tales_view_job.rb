class TalesViewJob < ApplicationJob
  queue_as :default

  def perform(tale)
    tale.increment!(:view_count)
  end
end
