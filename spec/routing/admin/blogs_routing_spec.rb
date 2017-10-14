require "rails_helper"

RSpec.describe Admin::BlogsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/blogs").to route_to("admin/blogs#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/blogs/new").to route_to("admin/blogs#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/blogs/1").to route_to("admin/blogs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/blogs/1/edit").to route_to("admin/blogs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/blogs").to route_to("admin/blogs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/blogs/1").to route_to("admin/blogs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/blogs/1").to route_to("admin/blogs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/blogs/1").to route_to("admin/blogs#destroy", :id => "1")
    end

  end
end
