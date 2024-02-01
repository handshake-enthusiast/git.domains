# frozen_string_literal: true

class User
  attr_accessor :id, :login, :access_token, :had_github_pages, :had_custom_domain, :default_branch

  def initialize(attributes = {})
    attributes.each do |key, value|
      send(:"#{key}=", value) if respond_to?(:"#{key}=")
    end
  end

  def update(attributes)
    update_clause = attributes.keys.map.with_index { |key, i| "#{key} = $#{i + 1}" }.join(', ')
    query = "UPDATE users SET #{update_clause} WHERE id = $#{attributes.length + 1}"

    parameters = attributes.values + [id]
    DB_POOL.with do |connection|
      connection.exec_params(query, parameters)
    end
  end

  def self.create(attributes)
    query = <<-SQL
      INSERT INTO users (id, login, access_token)
      VALUES ($1, $2, $3)
    SQL
    DB_POOL.with do |connection|
      connection.exec_params(query, [attributes[:id], attributes[:login], attributes[:access_token]])
    end
    new(attributes)
  end

  def self.find(id)
    query = 'SELECT * FROM users WHERE id = $1'
    user = nil

    DB_POOL.with do |connection|
      result = connection.exec_params(query, [id])
      user = cast_row(result.first)
    end

    user
  end

  def self.cast_row(row)
    return nil if row.nil?

    row['id'] = row['id'].to_i
    row['had_github_pages'] = cast_to_boolean(row['had_github_pages'])
    row['had_custom_domain'] = cast_to_boolean(row['had_custom_domain'])

    User.new(row)
  end

  def self.cast_to_boolean(value)
    return nil if value.nil?

    value == 't'
  end
end
