require "spec_helper"

describe StylesController do
  describe "routing" do

    it "routes to #index" do
      get("/styles").should route_to("styles#index")
    end

    it "routes to #new" do
      get("/styles/new").should route_to("styles#new")
    end

    it "routes to #show" do
      get("/styles/1").should route_to("styles#show", :id => "1")
    end

    it "routes to #edit" do
      get("/styles/1/edit").should route_to("styles#edit", :id => "1")
    end

    it "routes to #create" do
      post("/styles").should route_to("styles#create")
    end

    it "routes to #update" do
      put("/styles/1").should route_to("styles#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/styles/1").should route_to("styles#destroy", :id => "1")
    end

  end
end
