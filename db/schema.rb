# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_09_071858) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "feed_urls", force: :cascade do |t|
    t.string "url"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", default: "", null: false
    t.string "source", default: "", null: false
    t.string "source_url", default: "", null: false
    t.string "link", default: "", null: false
    t.datetime "publish_date"
    t.text "description", default: "", null: false
    t.index ["title", "source"], name: "index_posts_on_title_and_source", unique: true
  end

end
