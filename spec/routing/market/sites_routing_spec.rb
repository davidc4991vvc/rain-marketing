require "spec_helper"

describe Market::SitesController do
  describe "routing" do

    it "routes to #index" do
      get("/market/sites").should route_to("market/sites#index")
    end

    it "routes to #new" do
      get("/market/sites/new").should route_to("market/sites#new")
    end

    it "routes to #show" do
      get("/market/sites/1").should route_to("market/sites#show", :id => "1")
    end

    it "routes to #edit" do
      get("/market/sites/1/edit").should route_to("market/sites#edit", :id => "1")
    end

    it "routes to #create" do
      post("/market/sites").should route_to("market/sites#create")
    end

    it "routes to #update" do
      put("/market/sites/1").should route_to("market/sites#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/market/sites/1").should route_to("market/sites#destroy", :id => "1")
    end

  end
end
