class CreateReviews < ActiveRecord::Migration[7.2]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.string :genre, null: false
      t.string :author
      t.string :comment
      t.text :impression
      t.timestamps
    end
  end
end
