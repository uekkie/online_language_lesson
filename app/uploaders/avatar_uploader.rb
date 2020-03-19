class AvatarUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process :convert => 'png'
  process :tags => ['avatar']

  version :thumbnail do
    process :resize_to_fit => [32, 32]
  end

  def public_id
    return model.id
  end
end
