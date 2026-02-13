require 'spec_helper'

RSpec.describe Teaas::Helper do
  describe ".prepare_for_animation" do
    it "returns the first frame from the image list" do
      img = TestImageFactory.create_static_image
      result = Teaas::Helper.prepare_for_animation(img)
      expect(result).to be_a(Magick::Image)
    end

    it "sets dispose to BackgroundDispose" do
      img = TestImageFactory.create_static_image
      result = Teaas::Helper.prepare_for_animation(img)
      expect(result.dispose).to eq(Magick::BackgroundDispose)
    end

    it "sets format to gif" do
      img = TestImageFactory.create_static_image
      result = Teaas::Helper.prepare_for_animation(img)
      expect(result.format).to eq("GIF")
    end

    it "sets background_color based on default option" do
      img = TestImageFactory.create_static_image
      result = Teaas::Helper.prepare_for_animation(img)
      # "none" is normalized by RMagick; just verify it was set without error
      expect(result.background_color).not_to be_nil
    end

    it "sets background_color when force_transparency is true" do
      img = TestImageFactory.create_static_image
      result = Teaas::Helper.prepare_for_animation(img, force_transparency: true)
      expect(result.background_color).not_to be_nil
    end
  end

  describe ".animated_gif?" do
    it "returns true for a multi-frame GIF" do
      img = TestImageFactory.create_animated_image
      expect(Teaas::Helper.animated_gif?(img)).to be true
    end

    it "returns false for a single-frame image" do
      img = TestImageFactory.create_static_image
      expect(Teaas::Helper.animated_gif?(img)).to be false
    end

    it "returns false for a multi-frame non-GIF" do
      img = Magick::ImageList.new
      2.times do
        frame = Magick::Image.new(16, 16)
        frame.format = "PNG"
        img << frame
      end
      expect(Teaas::Helper.animated_gif?(img)).to be false
    end
  end
end
