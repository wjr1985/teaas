require 'spec_helper'

RSpec.describe Teaas::Marquee do
  describe "#marquee" do
    it "generates a marquee image" do
      static_image = Magick::ImageList.new

      static_image.from_blob(Base64.decode64("iVBORw0KGgoAAAANSUhEUgAAACAAAAAgAQAAAABbAUdZAAAABGdBTUEAALGP\nC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3Cc\nulE8AAAAAmJLR0QAAd2KE6QAAAAJcEhZcwAACxMAAAsTAQCanBgAAAAHdElN\nRQfgAgUQIQbuVAHWAAAAD0lEQVQI12P4DwQMg5cAANrpf4GXVFCUAAAAJXRF\nWHRkYXRlOmNyZWF0ZQAyMDE2LTAyLTA1VDE2OjMzOjA2LTA2OjAw2bi0+gAA\nACV0RVh0ZGF0ZTptb2RpZnkAMjAxNi0wMi0wNVQxNjozMzowNi0wNjowMKjl\nDEYAAAAASUVORK5CYII=\n"))
      marquee_image = double()

      expect(Magick::ImageList).to receive(:new).and_return(marquee_image)

      expect(static_image[0]).to receive(:roll).with(0, 0).and_call_original
      expect(static_image[0]).to receive(:roll).with(static_image.columns * 0.2, 0).and_call_original
      expect(static_image[0]).to receive(:roll).with(static_image.columns * 0.4, 0).and_call_original
      expect(static_image[0]).to receive(:roll).with(static_image.columns * 0.6, 0).and_call_original
      expect(static_image[0]).to receive(:roll).with(static_image.columns * 0.8, 0).and_call_original

      expect(marquee_image).to receive(:<<).exactly(5).times

      Teaas::Marquee.marquee(static_image, :horizontal => true)
    end
  end

  describe("#marquee_from_file") do
    it "calls marquee with image" do
      image = Magick::Image.new(32, 32)
      expect(Magick::Image).to receive(:read).and_return(image)

      expect(Teaas::Marquee).to receive(:marquee).with(image, {:horizontal => true})
      Teaas::Marquee.marquee_from_file("hello.png", :horizontal => true)
    end
  end
end
