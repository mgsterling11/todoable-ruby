require 'todoable/resources/resource_base'
require 'spec_helper'

RSpec.describe Todoable::Resources::TodoList do

  subject {
    config = {
        username: "km.nwani@gmail.com",
        password: "todoable"
    }
    Todoable::Client.new(config)
  }

  describe "list" do
    it "should list all todo-lists" do
      subject.todo_lists.list
    end
  end

end