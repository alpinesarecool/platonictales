class TalePostsController < ApplicationController
  def index
    @tale_posts = TalePost.order(:id)
  end

  # app/controllers/tale_posts_controller.rb

  def show
    @tale_post = TalePost.find(params[:id])
    @page_number = params[:page].to_i
    @content_pages = paginate_content(@tale_post.body, 500)
    @total_pages = @content_pages.size

    @page_content = @content_pages[@page_number] || @content_pages.last
    @feedback = Feedback.new
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Tale post not found."
  end

  def create_feedback
    Rails.logger.info "Params: #{params.inspect}"
    @tale_post = TalePost.find(params[:id])
    @feedback = @tale_post.feedbacks.build(feedback_params)
    @feedback.page_number = params[:feedback][:page_number]
    @feedback.title = @tale_post.title

    if @feedback.save
      redirect_to tale_post_path(@tale_post, page: @feedback.page_number), notice: "Feedback submitted successfully."
    else
      redirect_to tale_post_path(@tale_post, page: @feedback.page_number), alert: "Failed to submit feedback."
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:comment, :page_number)
  end

  def paginate_content(content, words_per_page)
    paragraphs = content.split("\n\n")
    pages = []
    current_page = ""
    current_word_count = 0

    paragraphs.each do |paragraph|
      paragraph_word_count = paragraph.split.size
      if current_word_count + paragraph_word_count > words_per_page
        pages << current_page
        current_page = ""
        current_word_count = 0
      end

      current_page += (current_page.empty? ? "" : "\n\n") + paragraph
      current_word_count += paragraph_word_count
    end

    pages << current_page unless current_page.empty?
    pages
  end
end
