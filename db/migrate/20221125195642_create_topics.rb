class CreateTopics < ActiveRecord::Migration[6.1]
  def change
    create_table :topics do |t|
      t.string :title
      t.integer :user_id
      t.timestamp :created_at
      t.timestamp :edited_at
      t.boolean :open
      t.integer :winner_idea
    end
  end
end
