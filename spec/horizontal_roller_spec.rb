require 'spec_helper'

RSpec.describe Teaas::HorizontalRoller do
  let(:img) { TestImageFactory.create_static_image(20, 20)[0] }

  describe ".roll" do
    it "rolls the image horizontally based on frame position" do
      result = Teaas::HorizontalRoller.roll(img, img_width: 20, img_height: 20, frame: 1, total_frames: 5)
      expect(result).to be_a(Magick::Image)
      expect(result.columns).to eq(20)
      expect(result.rows).to eq(20)
    end

    it "does not roll on frame 0" do
      result = Teaas::HorizontalRoller.roll(img, img_width: 20, img_height: 20, frame: 0, total_frames: 5)
      expect(result.columns).to eq(20)
    end

    it "rolls in reverse when reverse option is set" do
      result = Teaas::HorizontalRoller.roll(img, img_width: 20, img_height: 20, frame: 1, total_frames: 5, reverse: true)
      expect(result).to be_a(Magick::Image)
    end
  end
end
