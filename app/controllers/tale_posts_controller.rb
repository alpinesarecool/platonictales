class TalePostsController < ApplicationController
  def index
    @tale_posts = TalePost.order(:id)
  end

  # app/controllers/tale_posts_controller.rb

  def show
    @tale_post = TalePost.find(params[:id])
    @page_number = params[:page].to_i
    @content_pages = paginate_content(@tale_post.body, 500)
    @page_content = @content_pages[@page_number] || @content_pages.last
    TalesViewJob.perform_later(@tale_post)
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Tale post not found."
  end

  private

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
