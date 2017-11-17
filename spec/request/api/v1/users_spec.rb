require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  let(:version) { '/api/v1' }

  describe 'POST /api/v1/users' do
    let(:valid_attributes) { { email: Faker::Internet.email } }

    context 'when request is valid' do
      before { post "#{version}/users", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is invalid' do
      before { post "#{version}/users", params: { email: '' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'POST /api/v1/users/notifications' do
    let(:artist) { User.create!(email: 'foo@example.com') }
    let(:friend) { User.create!(email: 'bar@example.com') }
    let(:follower) { User.create!(email: 'follower@example.com') }
    let(:mention) { User.create!(email: 'mention@example.com') }
    let(:request) { { sender: 'foo@example.com', text: 'Hello world'} }

    context 'sender not found' do
      before { post "#{version}/users/notifications", params: request }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
        expect(response.body).to eq({errors: {success: false, message: "Couldn't find user with email foo@example.com"}}.to_json)
      end
    end

    context 'send to friend emails' do
      before {
        Friend.create!({user_id: artist.id, friend_id: friend.id})
        Friend.create!({user_id: friend.id, friend_id: artist.id})

        post "#{version}/users/notifications", params: request
      }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
        expect(response.body).to eq({success: true, recipients: ['bar@example.com']}.to_json)
      end
    end

    context 'send to subscriber emails' do
      before {
        Subscribe.create!({user_id: artist.id, subscriber_id: friend.id})

        post "#{version}/users/notifications", params: request 
      }
  
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
        expect(response.body).to eq({success: true, recipients: ['bar@example.com']}.to_json)
      end
    end

    context 'send to mentioned text' do
      before {
        post "#{version}/users/notifications", params: {sender: artist.email, text: "Hello @bar@example.com"} 
      }
  
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
        expect(response.body).to eq({success: true, recipients: ['bar@example.com']}.to_json)
      end
    end

    context 'send to all' do
      before {
        Friend.create!({user_id: artist.id, friend_id: friend.id})
        Friend.create!({user_id: friend.id, friend_id: artist.id})
        Subscribe.create!({user_id: artist.id, subscriber_id: follower.id})

        post "#{version}/users/notifications", params: {sender: artist.email, text: "Hello @mention@example.com"} 
      }
  
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
        expect(response.body).to eq({success: true, recipients: [friend.email, follower.email, mention.email]}.to_json)
      end
    end 

    context 'do not send to blocking emails' do
      before {
        Friend.create!({user_id: artist.id, friend_id: friend.id})
        Friend.create!({user_id: friend.id, friend_id: artist.id})
        Subscribe.create!({user_id: artist.id, subscriber_id: follower.id})
        Block.create!({user_id: mention.id, blocked_id: artist.id})

        post "#{version}/users/notifications", params: {sender: artist.email, text: "Hello @mention@example.com"} 
      }
  
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
        expect(response.body).to eq({success: true, recipients: [friend.email, follower.email]}.to_json)
      end
    end
    
  end
end