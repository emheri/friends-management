require 'rails_helper'

RSpec.describe Api::V1::SubscribesController, type: :request do
  let(:version) { '/api/v1' }

  describe 'POST /api/v1/subscribes' do
    context 'when subscribe success' do
      before {
        User.create!(email: 'foo@example.com')
        User.create!(email: 'bar@example.com')
      }
      let(:request) { {requestor: 'foo@example.com', target: 'bar@example.com'} }
      before { post "#{version}/subscribes", params: request }
      
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
        expect(response.body).to eq({success: true}.to_json)
      end
    end

    context 'when requestor not found' do
      before {
        User.create!(email: 'bar@example.com')
      }
      
      let(:request) { {requestor: 'foo@example.com', target: 'bar@example.com'} }
      before { post "#{version}/subscribes", params: request }
      
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
        expect(response.body).to eq({errors: {success: false, message: "requestor not found"}}.to_json)
      end
    end

    context 'when target not found' do
      before {
        User.create!(email: 'foo@example.com')
      }

      let(:request) { {requestor: 'foo@example.com', target: 'bar@example.com'} }
      before { post "#{version}/subscribes", params: request }
      
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
        expect(response.body).to eq({errors: {success: false, message: "target not found"}}.to_json)
      end
    end
  end
end
    