require "spec_helper"

describe Kwypper::Controller do
  context ".add_routes" do
    it "merges the hash argument with the ROUTES constant hash"
    it "sets the values of the ROUTES hash to an array of the controller class and action name"
  end

  context ".layout" do
    it "sets the layout name" 
  end

  context "#process" do
    it "sets the action"
    it "calls a method of the same name as the action on itself"
  end
end
