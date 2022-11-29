class CreateIdeas < ActiveRecord::Migration[6.1]
  def change
    create_table :ideas do |t|
      t.integer :topic_id
      t.integer :user_id
      t.string :body
      t.timestamp :created_at
      t.timestamp :updated_at
    end
  end
end
