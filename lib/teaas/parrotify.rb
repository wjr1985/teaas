module Teaas
  class Parrotify
    OFFSETS = [
      {:x_offset => 1, :y_offset => 1},
      {:x_offset => 0.8857, :y_offset => 0.98},
      {:x_offset => 0.7714, :y_offset => 0.98},
      {:x_offset => 0.6857, :y_offset => 1.02},
      {:x_offset => 0.6571, :y_offset => 1.04},
      {:x_offset => 0.7428, :y_offset => 1.08},
      {:x_offset => 0.8571, :y_offset => 1.12},
      {:x_offset => 0.9714, :y_offset => 1.12},
      {:x_offset => 1.0571, :y_offset => 1.1},
      {:x_offset => 1.0857, :y_offset => 1.08}
    ]


    # Best when used with {Teaas::Turboize.turbo} to generate multiple intense speeds.
    #
    # @param original_img [Array] An array of [Magick::ImageList]s
    # @return [Magick::ImageList] The parrotified image
    def self.parrotify(original_img, options={})
      parrotify_image = Magick::ImageList.new
      img = Teaas::Helper.prepare_for_animation(original_img)
      width = img.columns
      height = img.rows
      final_img = Magick::Image.new(width, height)
      final_img.format = "gif"
      parrotify_image = Magick::ImageList.new

      OFFSETS.each do |o|
        x_coord = width * (1 - o[:x_offset])
        y_coord = (height * (1 - o[:y_offset])) + (0.3 * height)
        parrotify_image << final_img.composite(img, x_coord, y_coord, Magick::OverCompositeOp)
      end

      parrotify_image
    end

    # Best when used with {Teaas::Turboize.turbo} to generate multiple intense speeds. Wrapper around {Teaas::Parrotify.parrotify}
    #
    # @param path [String] Path to the image to be created to an parrotified image
    # @return [Magick::ImageList] The parrotified image
    def self.parrotify_from_file(path, options={})
      img = Magick::Image.read(path)

      parrotify(img)
    end
  end
end
