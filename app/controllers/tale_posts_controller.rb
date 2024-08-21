class TalePostsController < ApplicationController
  def index
    @tale_posts = TalePost.order(:id)
  end

  def show
    @tale_post = TalePost.find(params[:id])
    TalesViewJob.perform_later(@tale_post)
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Tale post not found."
  end
end
