# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExifWorker, type: :worker do
  let!(:photo) { create(:photo) }

  it 'updates the exif field of photo' do
    worker = ExifWorker.new
    worker.perform(photo.id)
    expect(photo.reload.exif).not_to be_empty
  end
end
