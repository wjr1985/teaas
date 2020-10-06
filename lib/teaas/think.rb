module Teaas
  class Think
    # Takes in an image, and adds think to it. Best when used with {Teaas::Turboize.turbo} to generate multiple rotation speeds.
    #
    # @param original_img [Magick::ImageList] The image to be rotated
    # @return [Magick::ImageList] The spinning image
    def self.think(original_img, options={})
      Overlayer.overlay(original_img, Magick::ImageList.new(Teaas.root + "/img/thinking.png"), :static_on_animated => true, :gravity => Magick::SouthWestGravity)
    end

    # Takes in a path to an image, and adds think to it. Best when used with {Teaas::Turboize.turbo} to generate multiple rotation speeds. This is a wrapper around {Teaas::Spin.spin}
    #
    # @param path [String] Path to the image to be spun
    # @return [Magick::ImageList] The spinning image
    def self.think_from_file(path, options={})
      img = Magick::ImageList.new

      # Grab the first element in array to prevent strange things when an
      # animated image is submitted
      img.read(path)[0]

      think(img)
    end
  end
end
