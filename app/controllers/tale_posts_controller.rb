class TalePostsController < ApplicationController
  def index
    @tale_posts = TalePost.all
  end

  def show
    @tale_post = TalePost.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Tale post not found."
  end
end
