# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Photo, type: :model do
  let!(:photo) { create(:photo) }

  it 'contains correct urls' do
    dir = photo.file.store_dir
    expect(photo.original_url).to eq("#{dir}/#{photo.file.filename}")
    expect(photo.preview_url).to eq("#{dir}/preview_#{photo.file.filename}")
  end

  it 'has the correct format' do
    minimagick_image = MiniMagick::Image.new(photo.original_url)
    expect(minimagick_image.mime_type).to eq('image/jpeg')
  end

  context 'when the size is more than 5 Mb' do
    let(:image_url) { 'https://unsplash.com/photos/UhMYUFM1BYA' }
    subject { Photo.new(remote_file_url: image_url) }

    it { is_expected.to be_invalid }
  end

  context 'the preview version' do
    it 'scales down a photo to be exactly 600 by 600 pixels' do
      minimagick_image = MiniMagick::Image.new(photo.preview_url)
      expect(minimagick_image.dimensions).to eq([600, 600])
    end
  end
end
