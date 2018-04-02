module Todoable
  class Client
    attr_reader :config

    def initialize(config=nil)
      if config.nil? || config[:username].nil?
        raise ArgumentError.new("a valid :username argument is required to initialize a client")
      elsif config[:password].nil?
        raise ArgumentError.new("a valid :password argument is required to initialize a client")
      end

      @config=config
    end

  end
end