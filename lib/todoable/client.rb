require 'todoable/resources/todo_list'

module Todoable
  class Client
    attr_reader :config

    def initialize(config={})
      validate_config(config)
      @config=config
    end


    def todo_lists
      Todoable::Resources::TodoList.new(config)
    end


    private

    def validate_config(config)
      errors = []
      valid_arguments = [:username, :password]

      if config[:username].nil?
        errors << "a valid :username argument is required to initialize a client"
      end

      if config[:password].nil?
        errors << "a valid :password argument is required to initialize a client"
      end

      config.each_key { |key|
        if !valid_arguments.include?(key)
          errors << "unrecognized arguments exist in config; "\
                    "only :username and :password are required to initialize a client"
          break
        end
      }

      raise ArgumentError.new(errors) if errors.size > 0
    end
  end
end