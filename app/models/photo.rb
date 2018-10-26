class Photo < ApplicationRecord
  mount_uploader :file, PhotoUploader
  self.per_page = 5

  validates :file, file_size: { less_than_or_equal_to: 5.megabytes }

  def original_url
    file.url
  end

  def preview_url
    file.preview.url
  end
end
