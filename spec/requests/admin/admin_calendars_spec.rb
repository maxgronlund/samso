require 'rails_helper'

RSpec.describe "Admin::Calendars", type: :request do
  describe "GET /admin_calendars" do
    it "works! (now write some real specs)" do
      get admin_calendars_path
      expect(response).to have_http_status(200)
    end
  end
end
