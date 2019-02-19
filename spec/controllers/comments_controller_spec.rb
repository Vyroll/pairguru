require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
    context "GET #index" do
        it "succes response" do
            user = create(:user)
            sign_in user
            get :index
            expect(response).to be_successful
        end
    end
    
    context "GET #showcase" do
        it "succes response" do
            get :showcase
            expect(response).to be_successful
        end
    end
end
