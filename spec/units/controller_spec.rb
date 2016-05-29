require "spec_helper"

describe Kwypper::Controller do
  context ".add_routes" do
    it "merges the hash argument with the class' routes hash" do
      described_class.add_routes a: 1
      expect(described_class.routes).to include a: 1
    end
  end

  context ".layout" do
    it "sets the layout name" do
      described_class.layout "application.erb"
      expect(described_class.layout).to eq "application.erb"
    end
  end

  context "#process" do
    subject {described_class.new}
    it "sets the action" do
      subject.process :home
      expect(subject.action).to eq :home
    end
    it "calls a method of the same name as the action on itself" do
      expect(subject).to receive :home
      subject.process :home
    end
  end
end
