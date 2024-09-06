class CreateFeedbacks < ActiveRecord::Migration[7.2]
  def change
    create_table :feedbacks do |t|
      t.references :tale_post, null: false, foreign_key: true
      t.integer :page_number
      t.string :title
      t.text :comment

      t.timestamps
    end
  end
end
