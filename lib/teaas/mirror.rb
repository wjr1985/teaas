module Teaas
  class Mirror

    def self.mirror(original_img, options = {})
      if original_img[0].format == "GIF" && original_img.length > 1
        mirrored_image = Magick::ImageList.new
        original_img.each do |img|
          mirrored_image << img.flop
        end
        mirrored_image
      else
        original_img[0].flop
      end
    end

    def self.mirror_from_file(path, options = {})
      img = Magick::Image.read(path)

      mirror(img, options)
    end
  end
end
