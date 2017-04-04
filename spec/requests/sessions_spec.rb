require "rails_helper"

describe "Visitors Session Management", type: :request do

  describe "access root page" do
    describe "without being logged" do
      it "redirects to login page" do
        get root_path

        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "GET session#new" do
    it "returns status 200" do
      get new_user_session_path

      expect(response.status).to eq(200)
    end
  end

  describe "DELETE session#destroy " do
    it "logouts user" do
      delete destroy_user_session_path

      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "POST session#create" do
    it "redirects to root page" do
      post new_user_session_path, params: { language: "yoda", user: "username" }

      expect(response).to redirect_to root_path
    end
  end
end
