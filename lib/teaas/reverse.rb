module Teaas
  class Reverse
    def self.reverse(original_img, options = {})
      if Helper.animated_gif?(original_img)
        _reverse_animated_image(original_img, options)
      else
        original_img
      end
    end

    def self.reverse_from_file(path, options = {})
      img = Magick::Image.read(path)

      reverse(img, options)
    end

    def self._reverse_animated_image(original_img, options)
      reversed_image_list = []
      original_img.reverse_each { |i| reversed_image_list << i }

      new_image = Magick::ImageList.new
      reversed_image_list.each { |img| new_image << img }

      new_image
    end
  end
end
