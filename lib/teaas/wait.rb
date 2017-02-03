module Teaas
  class Wait
    # Takes in an image, and adds wait to it. Best when used with {Teaas::Turboize.turbo} to generate multiple rotation speeds.
    #
    # @param original_img [Magick::ImageList]
    # @return [Magick::ImageList]
    def self.wait(original_img)
      Overlayer.overlay(original_img, Magick::ImageList.new(Teaas.root + "/img/wait.gif"))
    end

    # Takes in a path to an image, and adds wait to it. Best when used with {Teaas::Turboize.turbo} to generate multiple rotation speeds. This is a wrapper around {Teaas::Wait.wait}
    #
    # @param path [String]
    # @return [Magick::ImageList]
    def self.wait_from_file(path)
      img = Magick::ImageList.new

      # Grab the first element in array to prevent strange things when an
      # animated image is submitted
      img.read(path)[0]

      wait(img)
    end
  end
end
