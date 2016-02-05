require 'spec_helper'

RSpec.describe Teaas::Turboize do
  describe "#spin" do
    it "rotates the image" do
      static_image = Magick::ImageList.new

      static_image.from_blob(Base64.decode64("iVBORw0KGgoAAAANSUhEUgAAACAAAAAgAQAAAABbAUdZAAAABGdBTUEAALGP\nC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3Cc\nulE8AAAAAmJLR0QAAd2KE6QAAAAJcEhZcwAACxMAAAsTAQCanBgAAAAHdElN\nRQfgAgUQIQbuVAHWAAAAD0lEQVQI12P4DwQMg5cAANrpf4GXVFCUAAAAJXRF\nWHRkYXRlOmNyZWF0ZQAyMDE2LTAyLTA1VDE2OjMzOjA2LTA2OjAw2bi0+gAA\nACV0RVh0ZGF0ZTptb2RpZnkAMjAxNi0wMi0wNVQxNjozMzowNi0wNjowMKjl\nDEYAAAAASUVORK5CYII=\n"))
      flattened_static_image = static_image.flatten_images
      spinny_image = double()

      expect(Magick::ImageList).to receive(:new).and_return(spinny_image)

      expect(static_image).to receive(:[]).and_return(flattened_static_image)

      expect(flattened_static_image).to receive(:rotate).with(90).and_call_original
      expect(flattened_static_image).to receive(:rotate).with(180).and_call_original
      expect(flattened_static_image).to receive(:rotate).with(270).and_call_original

      expect(spinny_image).to receive(:<<).exactly(4).times

      Teaas::Spin.spin(static_image)
    end
  end

  describe("#spin_from_file") do
    it "calls spin with image" do
      image = double()
      expect(image).to receive(:read).and_return([Magick::Image.new(32, 32)])

      expect(Magick::ImageList).to receive(:new).and_return(image)

      expect(Teaas::Spin).to receive(:spin).with(image)
      Teaas::Spin.spin_from_file("hello.png")
    end
  end
end
