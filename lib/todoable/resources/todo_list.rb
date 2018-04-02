require 'todoable/resources/resource_base'

module Todoable
  module Resources
    class TodoList < Todoable::Resources::ResourceBase

      def initialize(config)
        super(config)
        @endpoint = "lists"
      end

    end
  end
end