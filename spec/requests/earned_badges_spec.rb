require 'spec_helper'

describe "EarnedBadges" do
  describe "GET /earned_badges" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get earned_badges_path
      response.status.should be(200)
    end
  end
end
