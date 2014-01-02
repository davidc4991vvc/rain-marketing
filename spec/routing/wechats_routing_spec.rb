require "spec_helper"

describe WechatsController do
  describe "routing" do

    it "routes to #index" do
      get("/wechats").should route_to("wechats#index")
    end

    it "routes to #new" do
      get("/wechats/new").should route_to("wechats#new")
    end

    it "routes to #show" do
      get("/wechats/1").should route_to("wechats#show", :id => "1")
    end

    it "routes to #edit" do
      get("/wechats/1/edit").should route_to("wechats#edit", :id => "1")
    end

    it "routes to #create" do
      post("/wechats").should route_to("wechats#create")
    end

    it "routes to #update" do
      put("/wechats/1").should route_to("wechats#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/wechats/1").should route_to("wechats#destroy", :id => "1")
    end

  end
end
