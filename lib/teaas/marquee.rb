module Teaas
  class Marquee

    # Takes in an image, rolls it 25%, 50%, 75%, and 100%, then returns an animated marquee image. Best when used with {Teaas::Turboize.turbo} to generate multiple marquee speeds.
    #
    # @param original_img [Magick::ImageList] The image to be created into a marquee
    # @return [Magick::ImageList] The marquee image
    def self.marquee(original_img)
      marquee_image = Magick::ImageList.new
      img = original_img.flatten_images
      img.format = "gif"

      marquee_image << img
      marquee_image << img.roll(25, 0)
      marquee_image << img.roll(50, 0)
      marquee_image << img.roll(75, 0)
      marquee_image << img.roll(100, 0)

      marquee_image
    end

    # Takes in an image, rolls it 25%, 50%, 75%, and 100%, then returns an animated marquee image. Best when used with {Teaas::Turboize.turbo} to generate multiple marquee speeds. This is a wrapper around {Teaas::Marquee.marquee}
    #
    # @param path [String] Path to the image to be created to a marquee image
    # @return [Magick::ImageList] The marquee image
    def self.marquee_from_file(path)
      img = Magick::ImageList.new

      # Grab the first element in array to prevent strange things when an
      # animated image is submitted
      img.read(path)[0]

      marquee(img)
    end
  end
end
