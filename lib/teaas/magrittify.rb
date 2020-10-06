module Teaas
  class Magrittify
    # Takes in an image, and adds a green apple to it. Best when used with {Teaas::Turboize.turbo} to generate multiple rotation speeds.
    #
    # @param original_img [Magick::ImageList] The image
    # @return [Magick::ImageList] The new image
    def self.magrittify(original_img, options={})
      Overlayer.overlay(
        original_img,
        Magick::ImageList.new(Teaas.root + "/img/greenapple.png"),
        :static_on_animated => true,
        :gravity => Magick::CenterGravity,
        :overlay_resize => 0.6,
      )
    end

    # Takes in a path to an image, and adds a green apple to it. Best when used with {Teaas::Turboize.turbo} to generate multiple rotation speeds. This is a wrapper around {Teaas::Magrittify.magrittify}
    #
    # @param path [String] Path to the image
    # @return [Magick::ImageList] The new image
    def self.magrittify_from_file(path, options={})
      img = Magick::ImageList.new

      # Grab the first element in array to prevent strange things when an
      # animated image is submitted
      img.read(path)[0]

      magrittify(img)
    end
  end
end
