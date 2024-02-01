# frozen_string_literal: true

require 'connection_pool'
require 'pg'

DB_POOL = ConnectionPool.new(size: 20, timeout: 5) do
  PG.connect(
    host: DB_HOST,
    dbname: DB_NAME,
    user: DB_USER,
    password: DB_PASSWORD,
    port: DB_PORT
  )
end
DB_POOL.with do |connection|
  connection.exec <<-SQL
    CREATE TABLE IF NOT EXISTS users (
      id BIGINT PRIMARY KEY,
      login VARCHAR(255) NOT NULL,
      access_token VARCHAR(255) NOT NULL,
      had_github_pages BOOLEAN,
      had_custom_domain BOOLEAN,
      default_branch VARCHAR(255)
    );
  SQL
end
