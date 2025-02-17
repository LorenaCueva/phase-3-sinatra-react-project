# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_11_25_201209) do

  create_table "ideas", force: :cascade do |t|
    t.integer "topic_id"
    t.integer "user_id"
    t.string "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "idea_id"
    t.integer "user_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string "title"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "open"
    t.integer "winner_idea"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password"
  end

end
