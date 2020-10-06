module Teaas
  class Tears
    # Takes in an image, and adds tears to it. Best when used with {Teaas::Turboize.turbo} to generate multiple rotation speeds.
    #
    # @param original_img [Magick::ImageList] The image to be rotated
    # @return [Magick::ImageList] The spinning image
    def self.tears(original_img, options={})
      Overlayer.overlay(original_img, Magick::ImageList.new(Teaas.root + "/img/tears2.gif"))
    end

    # Takes in a path to an image, and adds tears to it. Best when used with {Teaas::Turboize.turbo} to generate multiple rotation speeds. This is a wrapper around {Teaas::Spin.spin}
    #
    # @param path [String] Path to the image to be spun
    # @return [Magick::ImageList] The spinning image
    def self.tears_from_file(path, options={})
      img = Magick::ImageList.new

      # Grab the first element in array to prevent strange things when an
      # animated image is submitted
      img.read(path)[0]

      tears(img)
    end
  end
end
