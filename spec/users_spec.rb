require 'spec_helper'

RSpec.describe UsersController do
  def app
    UsersController
  end

  before(:each) do
    User.delete_all
  end

  let(:user) { User.create(name: 'paul', email: 'paul@test.com', password: 'password123$', bio: 'rubyist') }

  describe 'GET /api/v1/users/:name' do

    it 'should return a user by name' do
      get "/api/v1/users/#{user.name}"

      expect(last_response).to be_ok
      expect(JSON.parse(last_response.body)['name']).to eq 'paul'
    end

    it 'should return a user with an email' do
      get "/api/v1/users/#{user.name}"

      expect(last_response).to be_ok
      expect(JSON.parse(last_response.body)['email']).to eq 'paul@test.com'
    end

    it "should not return a user's password" do
      get "/api/v1/users/#{user.name}"

      expect(last_response).to be_ok
      expect(JSON.parse(last_response.body)).not_to have_key('password')
    end

    it 'should return a user with bio' do
      get "/api/v1/users/#{user.name}"

      expect(last_response).to be_ok
      expect(JSON.parse(last_response.body)['bio']).to eq 'rubyist'
    end

    it "should return a 404 for a user that doesn't exist" do
      get '/api/v1/users/invalid'

      expect(last_response).to be_not_found
    end
  end

  describe 'POST /api/v1/users' do
    it 'should create a user' do
      params = { name: 'user', email: 'new_user@test.com', password: 'password', bio: 'worker' }
      post '/api/v1/users', params.to_json

      expect(last_response).to be_ok

      get "/api/v1/users/#{params[:name]}"

      attributes = JSON.parse(last_response.body)
      expect(attributes['name']).to eq params[:name]
      expect(attributes['email']).to eq params[:email]
      expect(attributes['bio']).to eq params[:bio]
    end
  end

  describe 'PUT /api/v1/users/:name' do
    it 'should update user' do
      params = { bio: 'worker' }
      put "/api/v1/users/#{user.name}", params.to_json

      expect(last_response).to be_ok

      get "/api/v1/users/#{user.name}"

      attributes = JSON.parse(last_response.body)
      expect(attributes['bio']).to eq params[:bio]
    end
  end

  describe 'DELETE /api/v1/users/:name' do
    it 'should delete a user' do
      delete "/api/v1/users/#{user.name}"

      expect(last_response).to be_ok

      get "/api/v1/users/#{user.name}"

      expect(last_response).to be_not_found
    end
  end

  describe 'POST /api/v1/users/:name/sessions' do
    it 'should return the user object on valid credentials' do
      puts "USER: #{user.inspect}"
      post "/api/v1/users/#{user.name}/sessions", { password: user.password }.to_json

      expect(last_response).to be_ok

      attributes = JSON.parse(last_response.body)
      expect(attributes['name']).to eq user.name
    end

    it 'should fail on invalid credentials' do
      post "/api/v1/users/#{user.name}/sessions", { password: 'invalid' }.to_json

      expect(last_response).to be_bad_request
    end
  end
end
