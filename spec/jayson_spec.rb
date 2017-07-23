require "spec_helper"

describe Jayson do
  it "has a version number" do
    expect(Jayson::VERSION).not_to be nil
  end

  it "parses {} as an object" do
    expect(Jayson.parse("{}")).to eq({})
  end
end
