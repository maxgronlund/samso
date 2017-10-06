require "rails_helper"

RSpec.describe Admin::CalendarsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/calendars").to route_to("admin/calendars#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/calendars/new").to route_to("admin/calendars#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/calendars/1").to route_to("admin/calendars#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/calendars/1/edit").to route_to("admin/calendars#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/calendars").to route_to("admin/calendars#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/calendars/1").to route_to("admin/calendars#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/calendars/1").to route_to("admin/calendars#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/calendars/1").to route_to("admin/calendars#destroy", :id => "1")
    end

  end
end
