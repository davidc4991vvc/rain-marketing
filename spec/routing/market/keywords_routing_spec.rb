require "spec_helper"

describe Market::KeywordsController do
  describe "routing" do

    it "routes to #index" do
      get("/market/keywords").should route_to("market/keywords#index")
    end

    it "routes to #new" do
      get("/market/keywords/new").should route_to("market/keywords#new")
    end

    it "routes to #show" do
      get("/market/keywords/1").should route_to("market/keywords#show", :id => "1")
    end

    it "routes to #edit" do
      get("/market/keywords/1/edit").should route_to("market/keywords#edit", :id => "1")
    end

    it "routes to #create" do
      post("/market/keywords").should route_to("market/keywords#create")
    end

    it "routes to #update" do
      put("/market/keywords/1").should route_to("market/keywords#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/market/keywords/1").should route_to("market/keywords#destroy", :id => "1")
    end

  end
end
