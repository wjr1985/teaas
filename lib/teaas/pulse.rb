module Teaas
  class Pulse

    # This is a snapshot of a broken version of Spin that creates a cool pulsing image.
    #
    # @param original_img [Magick::ImageList] The image to be rotated
    # @return [Magick::ImageList] The pulsing image
    def self.pulse(original_img, options={})
      pulsing_image = Magick::ImageList.new
      img = Teaas::Helper.prepare_for_animation(original_img)

      increment = 360 / 8

      8.times do |i|
        pulsing_image << img.rotate(increment * i+1).resize_to_fill(original_img.columns, original_img.rows)
      end

      pulsing_image
    end

    # This is a snapshot of a broken version of Spin that creates a cool pulsing image.
    #
    # @param path [String] Path to the image to be spun
    # @return [Magick::ImageList] The pulsing image
    def self.pulse_from_file(path, options={})
      img = Magick::ImageList.new

      # Grab the first element in array to prevent strange things when an
      # animated image is submitted
      img.read(path)[0]

      pulse(img)
    end
  end
end
