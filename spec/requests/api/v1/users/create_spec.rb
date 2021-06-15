require 'rails_helper'

RSpec.describe 'users controller' do
  describe 'you can create a user' do
    it 'returns email & api_key not password', :vcr do
      user_info = {email: 'test@test.edu', password: 'test', password_confirmation: 'test'}
      post "/api/v1/users", params: user_info.to_json
  
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response.server_error?).to eq(false)
      
      user = JSON.parse(response.body, symbolize_names: true)

      expect(user).to be_a Hash
      expect(user).to have_key(:data)
      expect(user[:data]).to be_a Hash

      udata = user[:data]
      expect(udata).to have_key(:id)
      expect(udata[:id]).to be_a String
      expect(udata).to have_key(:type)
      expect(udata[:type]).to eq('users')
      expect(udata).to have_key(:attributes)
      expect(udata[:attributes]).to be_a Hash

      expect(udata[:attributes]).to have_key :email
      expect(udata[:attributes][:email]).to be_a String
      expect(udata[:attributes]).to have_key :api_key
      expect(udata[:attributes][:api_key]).to be_a String
    end
  end

  describe 'SAD Path' do
    it 'Mismatching passwords return error', :vcr do
      user_info = {email: 'test@test.edu', password: 'terst', password_confirmation: 'test'}
      post "/api/v1/users", params: user_info.to_json

      expect(response.status).to eq(400)
      expect(response.server_error?).to eq(false)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a Hash
      expect(error).to have_key :errors
      expect(error[:errors]).to eq("Password confirmation doesn't match Password, Password confirmation doesn't match Password")
      expect(error).to have_key :status
      expect(error[:status]).to eq(400)
    end

    it 'Existing email cannot repeat', :vcr do
      User.create(email: 'test@test.edu', password: 'test', password_confirmation: 'test', api_key: 'sadtwqegqwegawest')
      user_info = {email: 'test@test.edu', password: 'test', password_confirmation: 'test'}
      post "/api/v1/users", params: user_info.to_json

      expect(response.status).to eq(400)
      expect(response.server_error?).to eq(false)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a Hash
      expect(error).to have_key :errors
      expect(error[:errors]).to eq('Email has already been taken')
      expect(error).to have_key :status
      expect(error[:status]).to eq(400)
    end

    it 'missing data fails', :vcr do
      user_info = {email: 'test@test.edu', password_confirmation: 'test'}
      post "/api/v1/users", params: user_info.to_json

      expect(response.status).to eq(400)
      expect(response.server_error?).to eq(false)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a Hash
      expect(error).to have_key :errors
      expect(error[:errors]).to eq("Password can't be blank, Password can't be blank, Password digest can't be blank, Password confirmation doesn't match Password")
      expect(error).to have_key :status
      expect(error[:status]).to eq(400)
    end
  end
end