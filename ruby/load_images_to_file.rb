require "bundler/setup"

require "redis"
require "mysql2"

# require_relative "app"

ENV["ISUBATA_DB_HOST"] = "db"
ENV["ISUBATA_DB_USER"] = "isucon"
ENV["ISUBATA_DB_PASSWORD"] = "isucon"

def db
@db_client ||= Mysql2::Client.new(
  host: ENV.fetch('ISUBATA_DB_HOST') { 'localhost' },
  port: ENV.fetch('ISUBATA_DB_PORT') { '3306' },
  username: ENV.fetch('ISUBATA_DB_USER') { 'root' },
  password: ENV.fetch('ISUBATA_DB_PASSWORD') { '' },
  database: 'isubata',
  encoding: 'utf8mb4'
)
@db_client.query('SET SESSION sql_mode=\'TRADITIONAL,NO_AUTO_VALUE_ON_ZERO,ONLY_FULL_GROUP_BY\'')
@db_client
end

def redis
  Redis.new(host: "app3632")
end

path = "../public/icons/"

db.prepare('SELECT name, data FROM image').execute().each do |x|
  name, data = x["name"], x["data"]
  puts name
  File.write(path + name, data)
end

