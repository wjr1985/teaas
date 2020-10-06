module Teaas
  class Helper
    def self.prepare_for_animation(img, options={})
      new_img = img[0]
      new_img.dispose = Magick::BackgroundDispose
      new_img.format = "gif"
      new_img.background_color = options[:force_transparency] ? "transparent" : "none"

      new_img
    end

    def self.animated_gif?(img)
      img[0].format == "GIF" && img.length > 1
    end
  end
end
