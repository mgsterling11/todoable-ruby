require 'date'

module Todoable
  module Resources
    class Auth

      attr_reader :token, :expiration_datetime

      def initialize(token, expires_at)
        @token = token
        @expiration_datetime = DateTime.parse(expires_at)
      end

      def expired?
        @expiration_datetime < DateTime.now
      end

    end
  end
end