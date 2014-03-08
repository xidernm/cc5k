require "spec_helper"

describe UsageTypesController do
  describe "routing" do

    it "routes to #index" do
      get("/usage_types").should route_to("usage_types#index")
    end

    it "routes to #new" do
      get("/usage_types/new").should route_to("usage_types#new")
    end

    it "routes to #show" do
      get("/usage_types/1").should route_to("usage_types#show", :id => "1")
    end

    it "routes to #edit" do
      get("/usage_types/1/edit").should route_to("usage_types#edit", :id => "1")
    end

    it "routes to #create" do
      post("/usage_types").should route_to("usage_types#create")
    end

    it "routes to #update" do
      put("/usage_types/1").should route_to("usage_types#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/usage_types/1").should route_to("usage_types#destroy", :id => "1")
    end

  end
end
