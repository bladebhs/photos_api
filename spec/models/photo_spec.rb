require 'rails_helper'

RSpec.describe Photo, type: :model do
  let!(:photo) { create(:photo) }

  it 'contains original and preview urls' do
    expect(photo.original).not_to be_empty
    expect(photo.preview).not_to be_empty
  end

  it 'has the correct format' do
    minimagick_image = MiniMagick::Image.new(photo.original)
    expect(minimagick_image.mime_type).to eq('image/jpeg')
  end

  context 'when the size is more than 5 Mb' do
    subject { Photo.new(remote_file_url: 'https://unsplash.com/photos/UhMYUFM1BYA/download?force=true') }

    it { is_expected.to be_invalid }
  end

  context 'the preview version' do
    it 'scales down a photo to be exactly 600 by 600 pixels' do
      minimagick_image = MiniMagick::Image.new(photo.preview)
      expect(minimagick_image.dimensions).to eq([600, 600])
    end
  end

  describe '.to_json' do
    it 'returns proper JSON structure' do
      expect(photo.to_json).to eq(
        {
          original_url: photo.original,
          preview_url: photo.preview,
          exif: ExifService.parse(photo.original)
        }.to_json
      )
    end
  end
end
