require 'todoable'
require 'spec_helper'

RSpec.describe Todoable::Client do

  it "should return a client object on valid user authentication" do
    todo_client = Todoable::Client.new(username: "km.nwani@gmail.com", password: "todoable")
    expect(todo_client).to be_instance_of Todoable::Client
  end

  it "should raise an error if no username or password is supplied" do
    expect { Todoable::Client.new }.to raise_error(ArgumentError)
  end

end
