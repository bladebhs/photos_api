class ExifWorker
  include Sidekiq::Worker

  def perform(photo)
    exif = ExifService.parse(photo.original_url)
    photo.update(exif: exif)
  end
end
