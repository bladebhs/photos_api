class ExifWorker
  include Sidekiq::Worker

  def perform(photo_id)
    photo = Photo.find(photo_id)
    exif = ExifService.parse(photo.original_url)
    photo.update(exif: exif)
  end
end
