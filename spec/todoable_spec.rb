require 'todoable'

RSpec.describe Todoable::Client do
  it "should return a client object on valid user authentication" do
    todo_client = Todoable::Client.new(username: "km.nwani@gmail.com", password: "todoable")
    expect(todo_client).to be_instance_of Todoable::Client
  end
end
