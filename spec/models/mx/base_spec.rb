require 'rails_helper'

RSpec.describe Mx::Base, type: :model do
  describe("credentials") do
    it "retrieves the credentials from the yaml file" do
      mx = Mx::Base.new
      credentials = mx.credentials

      expect(credentials.keys).to eq([:"MX-API-Key", :"MX-Client-ID", :"Accept"])
      expect(credentials[:"MX-API-Key"]).not_to be_nil
      expect(credentials[:"MX-Client-ID"]).not_to be_nil
    end
  end

  describe("query") do
    it("returns the results of a successful request") do
      mx = Mx::Base.new
      response = mx.query({
        :endpoint => "/institutions",
        :method   => :GET
      })

      expect(response.institutions.count).to eq(16)
    end

    it("returns the results of a failed request") do
      mx = Mx::Base.new
      response = mx.query({
        :endpoint => "/institutions",
        :method   => :POST
      })

      expect(response.error.message).to eq("Invalid route")
    end
  end
end
