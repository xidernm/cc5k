require 'spec_helper'

describe "RegionStatistics" do
  describe "GET /region_statistics" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get region_statistics_path
      response.status.should be(200)
    end
  end
end
