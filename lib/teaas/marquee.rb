module Teaas
  class Marquee

    # Takes in an image, rolls it 20%, 40%, 60%, and 80%, then returns an animated marquee image. Best when used with {Teaas::Turboize.turbo} to generate multiple marquee speeds.
    #
    # @param original_img [Array] An array of [Magick::ImageList]s
    # @return [Magick::ImageList] The marquee image
    def self.marquee(original_img)
      if original_img[0].format == "GIF" && original_img.length > 1
        _marquee_animated_image(original_img)
      else
        _marquee_static_image(original_img)
      end
    end

    # Takes in an image, rolls it 20%, 40%, 60%, and 80%, then returns an animated marquee image. Best when used with {Teaas::Turboize.turbo} to generate multiple marquee speeds. This is a wrapper around {Teaas::Marquee.marquee}
    #
    # @param path [String] Path to the image to be created to a marquee image
    # @return [Magick::ImageList] The marquee image
    def self.marquee_from_file(path)
      img = Magick::Image.read(path)

      marquee(img)
    end

    def self._marquee_animated_image(original_img)
      img_width = original_img[0].columns
      frames = original_img.length
      marquee_image = Magick::ImageList.new

      original_img.each_with_index do |img, i|
        img.dispose = Magick::BackgroundDispose
        marquee_image << img.roll(img_width * (i.to_f / frames), 0)
      end

      marquee_image
    end

    def self._marquee_static_image(original_img)
      marquee_image = Magick::ImageList.new
      img = Teaas::Helper.prepare_for_animation(original_img)

      img_width = img.columns

      marquee_image << img
      marquee_image << img.roll(img_width * 0.2, 0)
      marquee_image << img.roll(img_width * 0.4, 0)
      marquee_image << img.roll(img_width * 0.6, 0)
      marquee_image << img.roll(img_width * 0.8, 0)

      marquee_image
    end
  end
end
