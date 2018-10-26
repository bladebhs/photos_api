class PhotoSerializer
  include FastJsonapi::ObjectSerializer
  
  attributes :original_url, :preview_url, :exif
end
