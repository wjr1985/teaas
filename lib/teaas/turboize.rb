module Teaas
  class Turboize

    # Takes in an image, a resize parameter, and optionally speeds, and returns an image or images that are sped up or slowed down.
    #
    # @param img [Magick::ImageList] The image to be turboized
    # @param resize [Integer or Falsey] The size of the largest dimension (eg. 32) for the image, or falsey if no resizing should occur
    # @param speeds [Array] An array of Integers that determines the ticks per second for the resulting animated image
    # @return [Array] An array of image blobs that match each specified speed
    def self.turbo(img, resize, speeds=[2, 5, 10, 20, 30, 40], options={})
      speeds = [2, 5, 10, 20, 30, 40] if speeds.nil?
      if !resize.nil? && !resize.empty?
        img = Teaas::Resize.resize(img, resize, options)
      end

      image_blobs = []
      speeds.each do |turbo|
        image_blobs << turboize_individual_image(img, turbo, options).to_blob
      end

      image_blobs
    end

    # Takes in a path to an image, a resize parameter, and optionally speeds, and returns an image or images that are sped up or slowed down. This method is just a wrapper around {Teaas::Turboize.turbo}
    #
    # @param path [String] The path to the image to be turboized
    # @param resize Truthy if the image should be resized, falsey or nil if it should not
    # @param speeds [Array] An array of Integers that determines the ticks per second for the resulting animated image
    # @return [Array] An array of image blobs that match each specified speed
    def self.turbo_from_file(path, resize, speeds=[2, 5, 10, 20, 30, 40], options={})
      img = Magick::ImageList.new
      img.read(path)

      turbo(img, resize, speeds, options)
    end

    # Takes in a `Magick::ImageList` and adjusts the GIF image delay, ticks per second, and iterations.
    #
    # @param img [Magick::ImageList]
    # @param turbo [Integer] the ticks per second
    # @return [Magick::ImageList]
    def self.turboize_individual_image(img, turbo, options={})
      img.delay = options[:delay] || 1
      img.ticks_per_second = turbo
      img.iterations = 0
      img
    end
  end
end
