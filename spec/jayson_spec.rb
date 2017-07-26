require "spec_helper"

describe Jayson do
  it "has a version number" do
    expect(Jayson::VERSION).not_to be nil
  end



  describe '.parse' do
    it "parses {} as an object" do
      expect(Jayson.parse("{}")).to eq({})
    end

    describe 'strings values' do
      it %(parses {"abc":"abcd"} as  { "abc" => "abcd" } hash) do
        expect(Jayson.parse('{"abc":"abcd"}')).to eq({ "abc" => "abcd" })
      end

      it %(parses {"abc":"abcd"} as  { "abc" => "abcd" } hash with optional spaces) do
        expect(Jayson.parse('{ "abc":"abcd"}')).to eq({ "abc" => "abcd" })
        expect(Jayson.parse('{"abc" :"abcd"}')).to eq({ "abc" => "abcd" })
        expect(Jayson.parse('{"abc": "abcd"}')).to eq({ "abc" => "abcd" })
        expect(Jayson.parse('{"abc":"abcd" }')).to eq({ "abc" => "abcd" })
        expect(Jayson.parse('{ "abc" :"abcd"}')).to eq({ "abc" => "abcd" })
        expect(Jayson.parse('{ "abc": "abcd"}')).to eq({ "abc" => "abcd" })
        expect(Jayson.parse('{ "abc":"abcd" }')).to eq({ "abc" => "abcd" })
        expect(Jayson.parse('{ "abc" : "abcd"}')).to eq({ "abc" => "abcd" })
        expect(Jayson.parse('{ "abc" : "abcd" }')).to eq({ "abc" => "abcd" })
      end
    end

    describe 'integer values' do
      it %(parses {"abc": 1234 } as  { "abc" => 1234 } hash with optional spaces) do
        expect(Jayson.parse('{ "abc" : 1234 }')).to eq({ "abc" => 1234 })
      end
    end
  end
end
