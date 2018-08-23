# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180822204525) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actors", force: :cascade do |t|
    t.string "name"
    t.integer "moviedb_people_id"
    t.string "profile_path"
    t.index ["moviedb_people_id"], name: "index_actors_on_moviedb_people_id", unique: true
  end

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.integer "order"
    t.integer "actor_id"
    t.integer "movie_id"
  end

  create_table "crew_members", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "moviedb_people_id"
    t.string "name"
    t.string "department"
    t.string "job"
  end

  create_table "genres", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "moviedb_genre_id"
    t.index ["name"], name: "index_genres_on_name", unique: true
  end

  create_table "images", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "poster"
    t.integer "movie_id"
  end

  create_table "movie_characters", force: :cascade do |t|
    t.integer "movie_id"
    t.integer "character_id"
  end

  create_table "movie_crew_members", force: :cascade do |t|
    t.integer "movie_id"
    t.integer "crew_member_id"
  end

  create_table "movie_genres", force: :cascade do |t|
    t.integer "movie_id"
    t.integer "genre_id"
  end

  create_table "movies", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.text "overview"
    t.date "release_date"
    t.string "image"
    t.integer "moviedb_id"
    t.integer "likes", default: 0
    t.index ["moviedb_id"], name: "index_movies_on_moviedb_id", unique: true
  end

end
