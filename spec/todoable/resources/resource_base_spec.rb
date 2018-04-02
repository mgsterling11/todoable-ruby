require 'todoable/resources/resource_base'
require 'todoable/resources/auth'
require 'spec_helper'

RSpec.describe Todoable::Resources::ResourceBase do

  it "should authenticate if the client is not authorized" do
    resource_base = Todoable::Resources::ResourceBase.new({username: "km.nwani@gmail.com", password: "todoable"})
    expect(Todoable::Resources::ResourceBase.auth).not_to be_nil
    expect(Todoable::Resources::ResourceBase.auth.expired?).not_to be true
  end

end