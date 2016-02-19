require 'spec_helper'

RSpec.describe Teaas::Intensify do
  describe "#intensify" do
    it "generates a intensified image" do
      static_image = Magick::ImageList.new

      static_image.from_blob(Base64.decode64("iVBORw0KGgoAAAANSUhEUgAAACAAAAAgAQAAAABbAUdZAAAABGdBTUEAALGP\nC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3Cc\nulE8AAAAAmJLR0QAAd2KE6QAAAAJcEhZcwAACxMAAAsTAQCanBgAAAAHdElN\nRQfgAgUQIQbuVAHWAAAAD0lEQVQI12P4DwQMg5cAANrpf4GXVFCUAAAAJXRF\nWHRkYXRlOmNyZWF0ZQAyMDE2LTAyLTA1VDE2OjMzOjA2LTA2OjAw2bi0+gAA\nACV0RVh0ZGF0ZTptb2RpZnkAMjAxNi0wMi0wNVQxNjozMzowNi0wNjowMKjl\nDEYAAAAASUVORK5CYII=\n"))

      flattened_static_image = static_image.flatten_images
      intensified_image = double()

      expect(Magick::ImageList).to receive(:new).and_return(intensified_image).twice

      expect(static_image).to receive(:[]).and_return(flattened_static_image)

      expect(intensified_image).to receive(:<<).exactly(7).times

      Teaas::Intensify.intensify(static_image)
    end
  end

  describe("#intensify_from_file") do
    it "calls intensify with image" do
      image = Magick::Image.new(32, 32)
      expect(Magick::Image).to receive(:read).and_return(image)

      expect(Teaas::Intensify).to receive(:intensify).with(image)
      Teaas::Intensify.intensify_from_file("hello.png")
    end
  end
end
