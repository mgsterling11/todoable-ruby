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

  before :each do
    @sample_list_params = {
        list: {
            "name": "Urgent Things"
        }
    }

    @sample_item_params = {
        item: {
            "name": "Feed the cat"
        }
    }

    todo_lists = subject.todo_lists.list
    if !todo_lists["lists"].nil?
      todo_lists["lists"].each do |todo_list|
        subject.todo_lists.destroy(todo_list["id"])
      end
    end

    @new_list = subject.todo_lists.create(@sample_list_params)
    @new_list_id = @new_list["id"]
    @new_list_item = subject.todo_lists.create_item(@new_list_id, @sample_item_params)
  end

  describe "list" do
    it "should list all todo-lists" do
      subject.todo_lists.list
    end
  end

  describe "create" do
    it "should create a list object" do
      @sample_list_params[:list][:name] = "New List Name"
      new_list = subject.todo_lists.create(@sample_list_params)
      expect(new_list["name"]).to eql(@sample_list_params[:list][:name])
    end
  end

  describe "find" do
    it "should find a list object" do
      result = subject.todo_lists.find(@new_list_id)
      expect(result["name"]).to eql(@new_list["name"])
    end
  end

  describe "delete" do
    it "should delete a list object" do
      todo_lists = subject.todo_lists.list
      id = todo_lists["lists"].first["id"]

      subject.todo_lists.destroy(id)
      result = subject.todo_lists.find(id)
      expect(result.code).to eq('404')
    end
  end

  describe "update" do
    it "should update a pre-existing list object" do
      todo_lists = subject.todo_lists.list

      if todo_lists["lists"].empty?
        new_list = subject.todo_lists.create(@sample_list_params)
        id = new_list["id"]
      else
        id = todo_lists["lists"].first["id"]
      end

      @sample_list_params[:list][:name] = "Updated list name"
      result = subject.todo_lists.update(id, @sample_list_params)
      expect(result.code).to eq('200')
    end
  end

  describe "item" do
    it "should create an item in a list object" do
      new_list_item = subject.todo_lists.create_item(@new_list["id"], @sample_item_params)
      expect(new_list_item["name"]).to eql(@sample_item_params[:item][:name])
    end

    it "should finish an item" do
      result = subject.todo_lists.finish_item(@new_list_id, @new_list_item["id"])
      expect(result.code).to eql('200')
    end

    it "should delete a list item" do
      result = subject.todo_lists.destroy_item(@new_list_id, @new_list_item["id"])
      expect(result.code).to eql('204')
    end
  end

end