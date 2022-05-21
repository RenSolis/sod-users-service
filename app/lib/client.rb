class Client
  class << self
    attr_accessor :base_uri

    def find_by(name:)
      request = Typhoeus::Request.new(
        "#{base_uri}/api/v1/users/#{name}",
        method: :get
      )
      request.run

      response = request.response
      case response.code
      when 200
        JSON.parse(response.body)
      when 404
        nil
      else
        raise response.body
      end
    end

    def create(attributes)
      request = Typhoeus::Request.new(
        "#{base_uri}/api/v1/users",
        method: :post,
        body: attributes.to_json
      )
      request.run

      response = request.response
      if response.code == 200
        JSON.parse(response.body)
      else
        raise response.body
      end
    end

    def update(name, attributes)
      request = Typhoeus::Request.new(
        "#{base_uri}/api/v1/users/#{name}",
        method: :put,
        body: attributes.to_json
      )
      request.run

      response = request.response
      if response.code == 200
        JSON.parse(response.body)
      else
        raise response.body
      end
    end

    def destroy(name)
      request = Typhoeus::Request.new(
        "#{base_uri}/api/v1/users/#{name}",
        method: :delete
      )
      request.run

      response = request.response
      response.code == 200
    end

    def login(name, password)
      request = Typhoeus::Request.new(
        "#{base_uri}/api/v1/users/#{name}/sessions",
        method: :post,
        body: { password: password }.to_json
      )
      request.run

      response = request.response
      case response.code
      when 200
        JSON.parse(response.body)
      when 404
        nil
      else
        raise response.body
      end
    end
  end
end
