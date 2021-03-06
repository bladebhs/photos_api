class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :preview do
    process resize_to_fill: [600, 600]
  end

  def extension_whitelist
    %w(jpg jpeg)
  end
end
