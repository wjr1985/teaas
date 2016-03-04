module Teaas
  class Spin

    # Takes in an image, rotates it based on the number of rotations specified, then returns an animated spinning image. Best when used with {Teaas::Turboize.turbo} to generate multiple rotation speeds.
    #
    # @param original_img [Magick::ImageList] The image to be rotated
    # @return [Magick::ImageList] The spinning image
    def self.spin(original_img, options={})
      rotations = options[:rotations] ? options[:rotations] : 4
      spinny_image = Magick::ImageList.new
      img = Teaas::Helper.prepare_for_animation(original_img)

      increment = 360 / rotations

      rotations.times do |i|
        temp_img = img.rotate(increment * (i+1)).crop(Magick::NorthWestGravity, original_img.columns, original_img.rows, true)
        spinny_image << temp_img
      end

      spinny_image
    end

    # Takes in a path to an image, rotates it based on the number of rotations specified, then returns an animated spinning image. Best when used with {Teaas::Turboize.turbo} to generate multiple rotation speeds. This is a wrapper around {Teaas::Spin.spin}
    #
    # @param path [String] Path to the image to be spun
    # @return [Magick::ImageList] The spinning image
    def self.spin_from_file(path, options={})
      img = Magick::ImageList.new

      # Grab the first element in array to prevent strange things when an
      # animated image is submitted
      img.read(path)[0]

      spin(img, options)
    end
  end
end
