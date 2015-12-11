module Teaas
  class Spin

    # Takes in an image, rotates it 90, 180, and 270 degrees, then returns an animated spinning image. Best when used with {Teaas::Turboize.turbo} to generate multiple rotation speeds.
    #
    # @param original_img [Magick::ImageList] The image to be rotated
    # @return [Magick::ImageList] The spinning image
    def self.spin(original_img)
      spinny_image = Magick::ImageList.new
      img = original_img.flatten_images
      img.format = "gif"

      spinny_image << img
      spinny_image << img.rotate(90)
      spinny_image << img.rotate(180)
      spinny_image << img.rotate(270)

      spinny_image
    end

    # Takes in a path to an image, rotates it 90, 180, and 270 degrees, then returns an animated spinning image. Best when used with {Teaas::Turboize.turbo} to generate multiple rotation speeds. This is a wrapper around {Teaas::Spin.spin}
    #
    # @param path [String] Path to the image to be spun
    # @return [Magick::ImageList] The spinning image
    def self.spin_from_file(path)
      img = Magick::ImageList.new

      # Grab the first element in array to prevent strange things when an
      # animated image is submitted
      img.read(path)[0]

      spin(img)
    end
  end
end
