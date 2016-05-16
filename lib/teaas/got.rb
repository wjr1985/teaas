module Teaas
  class Got
    # Best when used with {Teaas::Turboize.turbo} to generate multiple rotation speeds.
    #
    # @param original_img [Magick::ImageList] The original image
    # @return [Magick::ImageList] The resulting image
    def self.got(original_img)
      fire_img = Overlayer.overlay(original_img, Magick::ImageList.new(Teaas.root + "/img/fire.gif"))
      Overlayer.overlay(fire_img, Magick::ImageList.new(Teaas.root + "/img/blood.gif"), :whitelisted_animation => true)
    end

    # Best when used with {Teaas::Turboize.turbo} to generate multiple rotation speeds. This is a wrapper around {Teaas::Got.got}
    #
    # @param path [String] Path to the image to be spun
    # @return [Magick::ImageList] The spinning image
    def self.got_from_file(path)
      img = Magick::ImageList.new

      # Grab the first element in array to prevent strange things when an
      # animated image is submitted
      img.read(path)[0]

      got(img)
    end
  end
end
