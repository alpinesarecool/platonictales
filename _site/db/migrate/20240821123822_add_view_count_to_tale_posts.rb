class AddViewCountToTalePosts < ActiveRecord::Migration[7.2]
  def change
    add_column :tale_posts, :view_count, :integer
  end
end
