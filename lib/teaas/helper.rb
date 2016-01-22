module Teaas
  class Helper
    def self.prepare_for_animation(img)
      new_img = img.flatten_images
      new_img.dispose = Magick::BackgroundDispose
      new_img.format = "gif"

      new_img
    end
  end
end
