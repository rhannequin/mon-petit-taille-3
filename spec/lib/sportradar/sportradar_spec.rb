# frozen_string_literal: true

require "spec_helper"
require "sportradar/sportradar"

describe Sportradar do
  let(:api_key) { "API_KEY" }

  it { expect(subject).to be_a Sportradar }

  describe "configuration" do
    subject { Sportradar.new(api_key: api_key) }

    it "can access to the API key" do
      expect(subject.current_options[:api_key]).to eq(api_key)
    end
  end

  describe "#api_call" do
    let(:endpoint) { "http://schemas.sportradar.com/bsa/standard/v2/json/endpoints/standard/tournaments.json" }
    subject { Sportradar.new(api_key: api_key) }

    it "return a new Faraday::Response instance" do
      expect(subject.api_call(endpoint)).to be_a Faraday::Response
    end
  end
end
