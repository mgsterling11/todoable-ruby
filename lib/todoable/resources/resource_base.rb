require 'todoable/resources/auth'
require 'net/http'
require 'uri'
require 'json'

module Todoable
  module Resources
    class ResourceBase
      @@auth = nil

      attr_reader :config, :endpoint

      def initialize(config)
        @config = config
        authenticate if @@auth.nil? || @@auth.expired?
      end

      def list
        puts "[list] endpoint=#{endpoint}"
        request = {
            method: :get,
            url: endpoint_url
        }

        submit(request)
      end

      def self.auth
        @@auth
      end

      private

      def submit(request)
        url     = request[:url]
        method  = request[:method]
        body    = request[:body]
        headers = request[:headers] || {}
        auth    = request[:auth] || nil

        uri = URI.parse(url)

        header = {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
        }

        if auth.nil?
          header['Authorization'] = "Token token=#{@@auth.token}"
        end

        http = Net::HTTP.new(uri.host, uri.port)

        case
        when method == :get
          req = Net::HTTP::Get.new(uri.request_uri, header)
        when method == :post
          req = Net::HTTP::Post.new(uri.request_uri, header)
        when method == :delete
          req = Net::HTTP::Delete.new(uri.request_uri, header)
        else
          raise ArgumentError.new("HTTP method '#{method}' is invalid")
        end

        if !auth.nil?
          req.basic_auth(auth[:username], auth[:password])
        end

        response = http.request(req)

        puts response.body
        JSON.parse(response.body)
      end

      def authenticate
        puts "[authenticate]"
        request = {
            method: :post,
            url: endpoint_url("authenticate"),
            auth: {username: config[:username], password: config[:password]}
        }
        body = submit(request)
        @@auth = Auth.new(body['token'], body['expires_at'])
      end

      def base_url
        "http://todoable.teachable.tech/api/"
      end

      def endpoint_url(override_endpoint=nil)
        if !override_endpoint.nil?
          "#{base_url}/#{override_endpoint}"
        else
          "#{base_url}/#{endpoint}"
        end
      end

      def resource_url(resource_id)
        "#{endpoint_url}/#{resource_id}"
      end

    end
  end
end