require 'active_record_migrations'

ActiveRecordMigrations.configure do |c|
  c.yaml_config = 'config/database.yml'
  c.db_dir = 'db'
  c.migrations_paths = ['db/migrations']
end

ActiveRecordMigrations.load_tasks
