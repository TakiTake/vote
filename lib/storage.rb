require 'redis'

class Storage
  class << self
    def redis
      @redis ||= Redis.new host: "127.0.0.1", port: "6379"
    end

    def find(key)
      redis.lrange key, 0, -1
    end

    def save(key, value)
      redis.lpush key, value
    end
  end
end
