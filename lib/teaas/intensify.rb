module Teaas
  class Intensify

    GRAVITY = [
      Magick::NorthWestGravity,
      Magick::SouthEastGravity,
      Magick::SouthWestGravity,
      Magick::NorthEastGravity,
      Magick::SouthEastGravity,
      Magick::NorthWestGravity,
      Magick::SouthWestGravity,
    ]

    # Takes in an image, composites a smaller version of it, then returns an animated intensified image image. Best when used with {Teaas::Turboize.turbo} to generate multiple intense speeds.
    #
    # @param original_img [Array] An array of [Magick::ImageList]s
    # @return [Magick::ImageList] The intensified image
    def self.intensify(original_img, options={})
      img = Teaas::Helper.prepare_for_animation(original_img)
      final_img = Magick::Image.new(img.columns, img.rows)
      final_img.format = "gif"
      intensify_image = Magick::ImageList.new

      img.change_geometry("95%x95%") do |cols, rows, i|
        i.resize!(cols, rows)
      end

      GRAVITY.each do |g|
        intensify_image << final_img.composite(img, g, Magick::OverCompositeOp)
      end

      intensify_image
    end

    # Takes in an image from a file, composites a smaller version of it, then returns an animated intensified image image. Best when used with {Teaas::Turboize.turbo} to generate multiple intense speeds. Wrapper around {Teaas::Intensifty.intensify}
    #
    # @param path [String] Path to the image to be created to an intensified image
    # @return [Magick::ImageList] The intensified image
    def self.intensify_from_file(path, options={})
      img = Magick::Image.read(path)

      intensify(img, options)
    end
  end
end
