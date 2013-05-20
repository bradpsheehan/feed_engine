require 'spec_helper'

describe Route do

  describe "path_points" do
    it "returns an array of hashes where the keys are symbols" do

      points = [{lat: '1.2', lng: '3.4'}, {lng:'1', lat:'2'}]
      json = points.to_json

      r = Route.new
      r.path = json

      expect(r.path_points).to eq points

    end
  end
end
