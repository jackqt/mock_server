class CreateMockdata < ActiveRecord::Migration

  def self.up

    create_table :mockdata do |t|
      t.string :mock_name
      t.string :mock_http_status
      t.text :mock_request_url
      t.text :mock_http_verb
      t.string :mock_data_response_headers
      t.text   :mock_data_response, limit: 1000000
      t.boolean :mock_state
      t.string :mock_environment
      t.string :mock_content_type
      t.integer :mock_served_times
      t.boolean :has_before_script
      t.text :before_script
      t.boolean :has_after_script
      t.text :after_script
      t.timestamps
    end

    execute <<-SQL
      CREATE UNIQUE INDEX "unique_mock_data"
      ON "MOCKDATA" ("mock_request_url","mock_http_verb", "mock_environment", "mock_state")
      WHERE "mock_state" = 't'
    SQL

    create_table :missed_requests do |t|
      t.string :url
      t.string :mock_http_verb
      t.string :mock_environment
      t.timestamps
    end

    create_table :replacedata do |t|
      t.string :replace_name
      t.string :replaced_string
      t.string :replacing_string
      t.boolean :is_regexp
      t.string :mock_environment
      t.boolean :replace_state
    end

    execute <<-SQL
      CREATE UNIQUE INDEX "unique_replace_data"
      ON "REPLACEDATA" ("replaced_string", "mock_environment", "replace_state")
      WHERE "replace_state" = 't'
    SQL

    end

  def self.down
    drop_table :mockdata
    drop_table :missed_requests
    drop_table :replacedata
  end
end