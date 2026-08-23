class FeedbacksController < ApplicationController
  before_action :authenticate, only: :index

  def index
    @feedbacks = Feedback.all
  end

  private

  def authenticate
    authenticate_or_request_with_http_basic do |_, password|
      # Hardcoded password for testing purposes or fetched from ENV
      password == ENV["FEEDBACKS_PASSWORD"]
    end
  end
end
