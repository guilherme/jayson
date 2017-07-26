require "spec_helper"

describe Jayson do
  it "has a version number" do
    expect(Jayson::VERSION).not_to be nil
  end

  it "parses {} as an object" do
    expect(Jayson.parse("{}")).to eq({})
  end
  it %(parses {"abc":"abcd"} as  { "abc" => "abcd" } hash) do
    expect(Jayson.parse('{"abc":"abcd"}')).to eq({ "abc" => "abcd" })
  end
end
