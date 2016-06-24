module Teaas
  class Marquee

    # Takes in an image, rolls it 20%, 40%, 60%, and 80%, then returns an animated marquee image. Best when used with {Teaas::Turboize.turbo} to generate multiple marquee speeds.
    #
    # @param original_img [Array] An array of [Magick::ImageList]s
    # @return [Magick::ImageList] The marquee image
    def self.marquee(original_img, options = {})
      if original_img[0].format == "GIF" && original_img.length > 1
        _marquee_animated_image(original_img, options)
      else
        _marquee_static_image(original_img, options)
      end
    end

    # Takes in an image, rolls it 20%, 40%, 60%, and 80%, then returns an animated marquee image. Best when used with {Teaas::Turboize.turbo} to generate multiple marquee speeds. This is a wrapper around {Teaas::Marquee.marquee}
    #
    # @param path [String] Path to the image to be created to a marquee image
    # @return [Magick::ImageList] The marquee image
    def self.marquee_from_file(path, options = {})
      img = Magick::Image.read(path)

      marquee(img, options)
    end

    def self._marquee_animated_image(original_img, options)
      img_width = original_img[0].columns
      img_height = original_img[0].rows
      if img_height > img_width
        crop = true && options[:crop]
        img_height = img_width
      else
        crop = false
      end

      frames = original_img.length
      marquee_image = Magick::ImageList.new

      original_img.each_with_index do |img, i|
        img.crop!(Magick::CenterGravity, img_width, img_width) if crop
        img.dispose = Magick::BackgroundDispose
        roller = _roller(options)
        marquee_image << roller.roll(
          img,
          :img_width => img_width,
          :img_height => img_height,
          :frame => i,
          :total_frames => frames,
          :reverse => options[:reverse],
        )
      end

      marquee_image
    end

    def self._marquee_static_image(original_img, options)
      marquee_image = Magick::ImageList.new
      img = Teaas::Helper.prepare_for_animation(original_img)

      img_width = img.columns
      img_height = img.rows

      if (img_height > img_width) && options[:crop]
        img.crop_resized!(img_width, img_width, Magick::CenterGravity)
        img_height = img_width
      end

      5.times do |i|
        roller = _roller(options)
        marquee_image << roller.roll(
          img,
          :img_width => img_width,
          :img_height => img_height,
          :frame => i,
          :total_frames => 5,
          :reverse => options[:reverse],
        )
      end

      marquee_image
    end

    def self._roller(options)
      if options[:horizontal]
        Teaas::HorizontalRoller
      else
        Teaas::VerticalRoller
      end
    end
  end
end
