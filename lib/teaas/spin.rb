module Teaas
  class Spin

    # Takes in an image, rotates it based on the number of rotations specified, then returns an animated spinning image. Best when used with {Teaas::Turboize.turbo} to generate multiple rotation speeds.
    #
    # @param original_img [Magick::ImageList] The image to be rotated
    # @return [Magick::ImageList] The spinning image
    def self.spin(original_img, options={})
      rotations = options[:rotations] ? options[:rotations] : 4
      counterclockwise = options[:counterclockwise]

      if Helper.animated_gif?(original_img)
        _spin_animated_image(original_img, rotations, counterclockwise)
      else
        _spin_static_image(original_img, rotations, counterclockwise)
      end
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

    def self._increment(increment, i, counterclockwise, rotations)
      if counterclockwise
        increment * (rotations - (i+1))
      else
        increment * (i+1)
      end
    end

    def self._spin_static_image(original_img, rotations, counterclockwise)
      spinny_image = Magick::ImageList.new
      img = Teaas::Helper.prepare_for_animation(original_img)

      increment = 360 / rotations

      rotations.times do |i|
        temp_img = img.rotate(_increment(increment, i, counterclockwise, rotations)).crop(Magick::NorthWestGravity, original_img.columns, original_img.rows, true)
        spinny_image << temp_img
      end

      spinny_image
    end

    def self._spin_animated_image(original_img, rotations, counterclockwise)
      frames = original_img.length
      original_img_list = Magick::ImageList.new

      original_img.each { |img| original_img_list << img }
      original_img_list = original_img.coalesce
      spinny_image = Magick::ImageList.new

      increment = 360 / rotations

      rotations.times do |i|
        original_img_list.each do |img|
          img.dispose = Magick::BackgroundDispose
          temp_img = img.rotate(_increment(increment, i, counterclockwise, rotations)).crop(Magick::NorthWestGravity, original_img_list.columns, original_img_list.rows, true)
          spinny_image << temp_img
        end
      end

      spinny_image
    end
  end
end
