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
end