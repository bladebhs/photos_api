# frozen_string_literal: true

require 'exifr/jpeg'

# Extract exif tags from the image
class ExifService
  class << self
    def parse(image_path)
      data = EXIFR::JPEG.new(image_path)
      comment_utf = data.user_comment.force_encoding('utf-8')

      {
        gps_latitude: data.gps.latitude,
        gps_longitude: data.gps.longitude,
        user_comment: JSON.parse(comment_utf)
      }
    end
  end
end
