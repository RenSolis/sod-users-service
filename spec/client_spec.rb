require 'spec_helper'

RSpec.describe 'Client' do
  before(:each) do
    User.delete_all
    Client.base_uri = 'http://localhost:4567'
  end

  let(:user) { User.create(name: 'paul', email: 'paul@pauldix.net', bio: 'rubyist') }

  it 'should get a user' do
    # you need to mock the request
    result = Client.find_by(name: 'paul')

    expect(result['name']).to eq user.name
    expect(result['email']).to eq user.email
    expect(result['bio']).to eq user.bio
  end

  it 'should return nil for a user not found' do
    expect(Client.find_by(name: 'invalid')).to be_nil
  end

  it 'should create a user' do
    # you need to mock the request
    result = Client.create(name: 'renzo', email: 'renzo@test.com', password: 'password')

    expect(result['name']).to eq 'renzo'
    expect(result['email']).to eq 'renzo@test.com'

    expect(Client.find_by(name: 'renzo')).to eq result
  end

  it 'should update a user' do
    # you need to mock the request
    result = Client.update(user.name, bio: 'rubyist and pythoner')

    expect(result['name']).to eq user.name
    expect(result['bio']).to eq user.reload.bio

    expect(Client.find_by(name: user.name)).to eq result
  end

  it 'should destroy a user' do
    expect(Client.destroy(user.name)).to be_truthy
    expect(Client.find_by(name: user.name)).to be_nil
  end

  it 'should verify login credentials' do
    result = User.login(user.name, user.password)

    expect(result['name']).to eq user.name
  end

  it 'should return nil with invalid credentials' do
    expect(User.login(user.name, 'invalid')).to be_nil
  end
end
