require "spec_helper"

describe RegionStatisticsController do
  describe "routing" do

    it "routes to #index" do
      get("/region_statistics").should route_to("region_statistics#index")
    end

    it "routes to #new" do
      get("/region_statistics/new").should route_to("region_statistics#new")
    end

    it "routes to #show" do
      get("/region_statistics/1").should route_to("region_statistics#show", :id => "1")
    end

    it "routes to #edit" do
      get("/region_statistics/1/edit").should route_to("region_statistics#edit", :id => "1")
    end

    it "routes to #create" do
      post("/region_statistics").should route_to("region_statistics#create")
    end

    it "routes to #update" do
      put("/region_statistics/1").should route_to("region_statistics#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/region_statistics/1").should route_to("region_statistics#destroy", :id => "1")
    end

  end
end
