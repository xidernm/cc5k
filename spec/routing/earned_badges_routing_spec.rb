require "spec_helper"

describe EarnedBadgesController do
  describe "routing" do

    it "routes to #index" do
      get("/earned_badges").should route_to("earned_badges#index")
    end

    it "routes to #new" do
      get("/earned_badges/new").should route_to("earned_badges#new")
    end

    it "routes to #show" do
      get("/earned_badges/1").should route_to("earned_badges#show", :id => "1")
    end

    it "routes to #edit" do
      get("/earned_badges/1/edit").should route_to("earned_badges#edit", :id => "1")
    end

    it "routes to #create" do
      post("/earned_badges").should route_to("earned_badges#create")
    end

    it "routes to #update" do
      put("/earned_badges/1").should route_to("earned_badges#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/earned_badges/1").should route_to("earned_badges#destroy", :id => "1")
    end

  end
end
