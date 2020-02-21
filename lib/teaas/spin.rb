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
        _spin_animated_image(original_img, rotations, counterclockwise, options)
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

    def self._x_offset(img, longest_side)
      if longest_side == img.rows
        -((img.rows / 2) - (img.columns / 2))
      else
        0
      end
    end

    def self._y_offset(img, longest_side)
      if longest_side == img.columns
        -((img.columns / 2) - (img.rows / 2))
      else
        0
      end
    end

    def self._spin_static_image(original_img, rotations, counterclockwise)
      if rotations != 4
        _spin_static_image_legacy(original_img, rotations, counterclockwise)
      else
        spinny_image = Magick::ImageList.new
        img = Teaas::Helper.prepare_for_animation(original_img)
        longest_side = img.rows > img.columns ? img.rows : img.columns

        increment = 360 / rotations

        rotations.times do |i|
          rotated_img = img.rotate(_increment(increment, i, counterclockwise, rotations))

          resized_img = rotated_img.extent(longest_side, longest_side, _x_offset(rotated_img, longest_side), _y_offset(rotated_img, longest_side))
          spinny_image << resized_img
        end

        spinny_image
      end
    end

    def self._spin_animated_image(original_img, rotations, counterclockwise, options)
      if rotations != 4
        _spin_animated_image_legacy(original_img, rotations, counterclockwise, options)
      else
        longest_side = original_img[0].rows > original_img[0].columns ? original_img[0].rows : original_img[0].columns

        original_img_list = Magick::ImageList.new
        original_img.each { |img| original_img_list << img }
        original_img_list = original_img.coalesce

        spinny_image = Magick::ImageList.new

        increment = 360 / rotations

        rotations.times do |i|
          original_img_list.each do |img|
            img.background_color = options[:force_transparency] ? "transparent" : "white"
            img.dispose = Magick::BackgroundDispose
            rotated_img = img.rotate(_increment(increment, i, counterclockwise, rotations))

            resized_img = rotated_img.extent(longest_side, longest_side, _x_offset(rotated_img, longest_side), _y_offset(rotated_img, longest_side))
            spinny_image << resized_img
          end
        end

        spinny_image
      end
    end

    def self._spin_static_image_legacy(original_img, rotations, counterclockwise)
      spinny_image = Magick::ImageList.new
      img = Teaas::Helper.prepare_for_animation(original_img)

      increment = 360 / rotations

      rotations.times do |i|
        temp_img = img.rotate(_increment(increment, i, counterclockwise, rotations)).crop(Magick::NorthWestGravity, original_img.columns, original_img.rows, true)
        spinny_image << temp_img
      end

      spinny_image
    end

    def self._spin_animated_image_legacy(original_img, rotations, counterclockwise, options)
      frames = original_img.length
      original_img_list = Magick::ImageList.new

      original_img.each { |img| original_img_list << img }
      original_img_list = original_img.coalesce
      spinny_image = Magick::ImageList.new

      increment = 360 / rotations

      rotations.times do |i|
        original_img_list.each do |img|
          img.dispose = Magick::BackgroundDispose
          img.background_color = options[:force_transparency] ? "transparent" : "white"
          temp_img = img.rotate(_increment(increment, i, counterclockwise, rotations)).crop(Magick::NorthWestGravity, original_img_list.columns, original_img_list.rows, true)
          spinny_image << temp_img
        end
      end

      spinny_image
    end
  end
end
