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

ActiveRecord::Schema[7.1].define(version: 1) do
  create_table "httprequestlogs", force: :cascade do |t|
    t.string "request_http_verb"
    t.string "request_url"
    t.string "request_query_string"
    t.text "request_body", limit: 1000000
    t.text "request_headers"
    t.string "request_environment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "missed_requests", force: :cascade do |t|
    t.string "url"
    t.string "mock_http_verb"
    t.string "mock_environment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mockdata", force: :cascade do |t|
    t.string "mock_name"
    t.string "mock_http_status"
    t.text "mock_request_url"
    t.text "mock_http_verb"
    t.string "mock_data_response_headers"
    t.text "mock_data_response", limit: 1000000
    t.boolean "mock_state"
    t.string "mock_environment"
    t.string "mock_content_type"
    t.integer "mock_served_times"
    t.boolean "has_before_script"
    t.string "before_script_name"
    t.boolean "has_after_script"
    t.string "after_script_name"
    t.string "profile_name"
    t.text "mock_cookie"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mock_request_url", "mock_http_verb", "mock_environment", "mock_state"], name: "unique_mock_data", unique: true
  end

  create_table "replacedata", force: :cascade do |t|
    t.string "replace_name"
    t.string "replaced_string"
    t.string "replacing_string"
    t.boolean "is_regexp"
    t.string "mock_environment"
    t.boolean "replace_state"
    t.index ["replaced_string", "mock_environment", "replace_state"], name: "unique_replace_data", unique: true
  end

  create_table "rubyscripts", force: :cascade do |t|
    t.string "script_name"
    t.text "script_body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
