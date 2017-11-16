require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  let(:version) { '/api/v1' }
  
  describe 'POST /api/v1/friends/connect' do
    let(:friends) { { friends: ['foo@example.com', 'bar@example.com'] } }
    
    context 'when valid connection' do
      before {
        User.create!(email: 'foo@example.com')
        User.create!(email: 'bar@example.com')
      }
      
      before { post "#{version}/friends/connect", params: friends }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
        expect(response.body).to eq({success: true}.to_json)
      end
    end

    context 'when emails already connected' do
      before {
        foo = User.create!(email: 'foo@example.com')
        bar = User.create!(email: 'bar@example.com')
        Friend.create!(user_id: foo.id, friend_id: bar.id)
      }
      
      before { post "#{version}/friends/connect", params: friends }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
        expect(response.body).to eq({errors: {success: false, message: "emails already connected"}}.to_json)
      end
    end

    context 'when only have one email' do
      let(:one_email) { { friends: ['foo@example.com'] } }
      before { post "#{version}/friends/connect", params: one_email }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
        expect(response.body).to eq({errors: {success: false, message: "number of emails should equal two"}}.to_json)
      end
    end

    context 'when email has not registered' do
      before { post "#{version}/friends/connect", params: friends }
      
      it 'returns status code 400' do
        expect(response).to have_http_status(400)
        expect(response.body).to eq({errors: {success: false, message: "The following emails #{friends[:friends]} has not been registered"}}.to_json)
      end
    end

    context 'when have same email' do
      let(:same_email) { { friends: ['foo@example.com', 'foo@example.com'] } }
      before { post "#{version}/friends/connect", params: same_email }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
        expect(response.body).to eq({errors: {success: false, message: "Can't create connection with same email"}}.to_json)
      end
    end
  end
end