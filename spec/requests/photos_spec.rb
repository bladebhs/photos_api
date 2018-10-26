# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'

describe 'Photos API', type: :request do
  context 'request without a token' do
    it 'returns status code 401' do
      get '/api/photos'

      expect(response).to have_http_status(401)
    end
  end

  describe 'POST /api/photos' do
    let(:valid_photo) { { photo: attributes_for(:photo) } }
    let(:png_image) { 'spec/fixtures/files/bird.png' }
    let(:invalid_photo) do
      {
        photo:
        {
          file: fixture_file_upload(png_image, 'image/png')
        }
      }
    end

    context 'with valid parameters' do
      let(:post_action) do
        post '/api/photos', headers: authenticated_header,
                            params: valid_photo
      end

      it 'returns status code 201' do
        post_action
        expect(response).to have_http_status(201)
      end

      it 'executes ExifWorker' do
        Sidekiq::Testing.fake!
        expect { post_action }.to change { ExifWorker.jobs.size }.by(1)
      end
    end

    context 'with invalid parameters' do
      before do
        post '/api/photos', headers: authenticated_header,
                            params: invalid_photo
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'GET /api/photos' do
    let!(:photos) { create_list(:photo, 3) }
    let(:photo) { photos[0] }
    before { get '/api/photos', headers: authenticated_header }

    it 'returns photos' do
      expect(json).not_to be_empty
      expect(json[:data].size).to eq(3)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns proper JSON structure' do
      expect(json[:data][0]).to eq(
        id: photo.id.to_s,
        type: 'photo',
        attributes: {
          original_url: photo.original_url,
          preview_url: photo.preview_url,
          exif: photo.exif
        }
      )
    end
  end
end
