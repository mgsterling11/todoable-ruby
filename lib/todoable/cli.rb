require 'thor'
require 'todoable/client'

module Todoable
  class CLI < Thor
    class_option :username, required: true
    class_option :pass, required: true

    desc "create_list NAME", "Creates a new list with the provided name if it does not exist"
    def create_list(name)
      config = {
          username: options[:username],
          password: options[:pass]
      }
      client = Todoable::Client.new(config)
      puts client.todo_lists.create({"list": {"name": name }})
    end

    desc "destroy_list ID", "Deletes a specified list with the provided id if it exists"
    def delete_list(id)
      config = {
          username: options[:username],
          password: options[:pass]
      }
      client = Todoable::Client.new(config)
      puts client.todo_lists.destroy(id)
    end

    desc "see_lists", "Shows all created lists for the user"
    def see_lists
      config = {
          username: options[:username],
          password: options[:pass]
      }
      client = Todoable::Client.new(config)
      puts client.todo_lists.list
    end

  end
end