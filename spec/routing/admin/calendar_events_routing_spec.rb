require "rails_helper"

RSpec.describe Admin::CalendarEventsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/calendar_events").to route_to("admin/calendar_events#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/calendar_events/new").to route_to("admin/calendar_events#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/calendar_events/1").to route_to("admin/calendar_events#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/calendar_events/1/edit").to route_to("admin/calendar_events#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/calendar_events").to route_to("admin/calendar_events#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/calendar_events/1").to route_to("admin/calendar_events#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/calendar_events/1").to route_to("admin/calendar_events#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/calendar_events/1").to route_to("admin/calendar_events#destroy", :id => "1")
    end

  end
end
