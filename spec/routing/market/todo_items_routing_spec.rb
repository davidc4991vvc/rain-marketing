require "spec_helper"

describe Market::TodoItemsController do
  describe "routing" do

    it "routes to #index" do
      get("/market/todo_items").should route_to("market/todo_items#index")
    end

    it "routes to #new" do
      get("/market/todo_items/new").should route_to("market/todo_items#new")
    end

    it "routes to #show" do
      get("/market/todo_items/1").should route_to("market/todo_items#show", :id => "1")
    end

    it "routes to #edit" do
      get("/market/todo_items/1/edit").should route_to("market/todo_items#edit", :id => "1")
    end

    it "routes to #create" do
      post("/market/todo_items").should route_to("market/todo_items#create")
    end

    it "routes to #update" do
      put("/market/todo_items/1").should route_to("market/todo_items#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/market/todo_items/1").should route_to("market/todo_items#destroy", :id => "1")
    end

  end
end
