require 'todoable/resources/auth'
require 'net/http'
require 'uri'
require 'json'

module Todoable
  module Resources
    class ResourceBase
      @@auth = nil

      attr_reader :config, :endpoint

      def self.auth
        @@auth
      end

      def initialize(config)
        @config = config
        authenticate if @@auth.nil? || @@auth.expired?
      end

      def list
        request = {
            method: :get,
            url: endpoint_url
        }

        submit(request)
      end

      def find(resource_id)
        headers = {
            'Accept': 'application/json'
        }

        request = {
            method: :get,
            url: resource_url(resource_id),
            headers: headers
        }

        submit(request)
      end

      def create(body={})
        headers = {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
        }

        request = {
            method: :post,
            url: endpoint_url,
            body: body,
            headers: headers
        }

        submit(request)
      end

      def destroy(resource_id)
        headers = {
            'Accept': 'application/json'
        }

        request = {
            method: :delete,
            url: resource_url(resource_id),
            headers: headers
        }

        submit(request)
      end

      def update(resource_id, body={})
        headers = {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
        }

        request = {
            method: :patch,
            url: resource_url(resource_id),
            body: body,
            headers: headers
        }

        submit(request)
      end

      private

      def submit(request)
        url     = request[:url]
        method  = request[:method]
        body    = request[:body] || {}
        headers = request[:headers] || {}
        auth    = request[:auth] || nil

        uri = URI.parse(url)

        if auth.nil?
          headers['Authorization'] = "Token token=#{@@auth.token}"
        end

        http = Net::HTTP.new(uri.host, uri.port)

        case
        when method == :get
          req = Net::HTTP::Get.new(uri.request_uri, headers)
        when method == :put
          req = Net::HTTP::Put.new(uri.request_uri, headers)
        when method == :post
          req = Net::HTTP::Post.new(uri.request_uri, headers)
          req.body = body.to_json if !body.empty?
        when method == :delete
          req = Net::HTTP::Delete.new(uri.request_uri, headers)
        when method == :patch
          req = Net::HTTP::Patch.new(uri.request_uri, headers)
          req.body = body.to_json if !body.empty?
        else
          raise ArgumentError.new("HTTP method '#{method}' is invalid")
        end

        if !auth.nil?
          req.basic_auth(auth[:username], auth[:password])
        end

        response = http.request(req)

        begin
          return JSON.parse(response.body) if !response.body.nil?
        rescue JSON::ParserError => e
        end

        response
      end

      def authenticate
        puts "[authenticate]"
        headers = {
            'Accept': 'application/json'
        }

        request = {
            method: :post,
            url: endpoint_url("authenticate"),
            headers: headers,
            auth: {username: config[:username], password: config[:password]}
        }

        body = submit(request)
        @@auth = Auth.new(body['token'], body['expires_at'])
      end

      def base_url
        "http://todoable.teachable.tech/api"
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