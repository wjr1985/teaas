module Teaas
  class Overlayer
    def self.overlay(original_img, overlay_img)
      image = Magick::ImageList.new
      img = Teaas::Helper.prepare_for_animation(original_img)
      overlay_img.each do |image|
        image.resize_to_fit!(img.columns, img.rows)
      end
      image << img

      image = image.composite_layers(overlay_img)

      image
    end
  end
end
