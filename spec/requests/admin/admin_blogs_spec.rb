require 'rails_helper'

RSpec.describe "Admin::Blogs", type: :request do
  describe "GET /admin_blogs" do
    it "works! (now write some real specs)" do
      get admin_blogs_path
      expect(response).to have_http_status(200)
    end
  end
end
