require 'spec_helper'

RSpec.describe UsersController do
  def app
    UsersController
  end

  before(:each) do
    User.delete_all
  end

  describe 'GET /api/v1/users/:name' do
    let(:user) { User.create(name: 'paul', email: 'paul@test.com', password: 'password123$', bio: 'rubyist') }

    it 'should return a user by name' do
      get "/api/v1/users/#{user.name}"

      expect(last_response.status).to eq 200
      expect(JSON.parse(last_response.body)['name']).to eq 'paul'
    end

    it 'should return a user with an email' do
      get "/api/v1/users/#{user.name}"

      expect(last_response.status).to eq 200
      expect(JSON.parse(last_response.body)['email']).to eq 'paul@test.com'
    end

    it "should not return a user's password" do
      get "/api/v1/users/#{user.name}"

      expect(last_response.status).to eq 200
      expect(JSON.parse(last_response.body)).not_to have_key('password')
    end

    it 'should return a user with bio' do
      get "/api/v1/users/#{user.name}"

      expect(last_response.status).to eq 200
      expect(JSON.parse(last_response.body)['bio']).to eq 'rubyist'
    end

    it "should return a 404 for a user that doesn't exist" do
      get '/api/v1/users/invalid'

      expect(last_response.status).to eq 404
    end
  end
end
