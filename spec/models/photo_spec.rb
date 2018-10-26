# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Photo, type: :model do
  let!(:photo) { create(:photo) }

  it 'contains original and preview urls' do
    expect(photo.original_url).not_to be_empty
    expect(photo.preview_url).not_to be_empty
  end

  it 'has the correct format' do
    minimagick_image = MiniMagick::Image.new(photo.original_url)
    expect(minimagick_image.mime_type).to eq('image/jpeg')
  end

  context 'when the size is more than 5 Mb' do
    subject { Photo.new(remote_file_url: 'https://unsplash.com/photos/UhMYUFM1BYA/download?force=true') }

    it { is_expected.to be_invalid }
  end

  context 'the preview version' do
    it 'scales down a photo to be exactly 600 by 600 pixels' do
      minimagick_image = MiniMagick::Image.new(photo.preview_url)
      expect(minimagick_image.dimensions).to eq([600, 600])
    end
  end

  describe '.to_json' do
    it 'returns proper JSON structure' do
      worker = ExifWorker.new
      worker.perform(photo)
      expect(PhotoSerializer.new(photo).serialized_json).to eq(
        {
          data: {
            id: photo.id.to_s,
            type: 'photo',
            attributes: {
              original_url: photo.original_url,
              preview_url: photo.preview_url,
              exif: photo.exif
            }
          }
        }.to_json
      )
    end
  end
end
