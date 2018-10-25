class Photo < ApplicationRecord
  mount_uploader :file, PhotoUploader

  validates :file, file_size: { less_than_or_equal_to: 5.megabytes }

  def original
    file.url
  end

  def preview
    file.preview.url
  end
end
