module Teaas
  class Fireworks
    # Takes in an image, and adds fireworks to it. Best when used with {Teaas::Turboize.turbo} to generate multiple rotation speeds.
    #
    # @param original_img [Magick::ImageList] The image to be showered with fireworks
    # @return [Magick::ImageList] The image, now more festive
    def self.fireworks(original_img, options={})
      Overlayer.overlay(original_img, Magick::ImageList.new(Teaas.root + "/img/fireworks.gif"))
    end

    # Takes in a path to an image, and adds fireworks to it. Best when used with {Teaas::Turboize.turbo} to generate multiple rotation speeds. This is a wrapper around {Teaas::Fireworks.fireworks}
    #
    # @param path [String] Path to the image to be showered with fireworks
    # @return [Magick::ImageList] The image, now more festive
    def self.fireworks_from_file(path, options={})
      img = Magick::ImageList.new

      # Grab the first element in array to prevent strange things when an
      # animated image is submitted
      img.read(path)[0]

      fireworks(img)
    end
  end
end
