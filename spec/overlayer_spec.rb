require 'spec_helper'

RSpec.describe Teaas::Overlayer do
  let(:static_img) { TestImageFactory.create_static_image(16, 16) }
  let(:animated_img) { TestImageFactory.create_animated_image(16, 16, 3) }

  describe ".overlay" do
    it "dispatches to overlay_animated_on_static by default" do
      overlay = TestImageFactory.create_animated_image(16, 16, 2)
      expect(Teaas::Overlayer).to receive(:overlay_animated_on_static).and_call_original
      Teaas::Overlayer.overlay(static_img, overlay)
    end

    it "dispatches to overlay_static_on_animated when option set" do
      overlay = TestImageFactory.create_static_image(16, 16)
      expect(Teaas::Overlayer).to receive(:overlay_static_on_animated).and_call_original
      Teaas::Overlayer.overlay(animated_img, overlay, static_on_animated: true)
    end

    it "dispatches to overlay_animated_on_animated when whitelisted_animation set" do
      overlay = TestImageFactory.create_animated_image(16, 16, 2)
      expect(Teaas::Overlayer).to receive(:overlay_animated_on_animated).and_call_original
      Teaas::Overlayer.overlay(animated_img, overlay, whitelisted_animation: true)
    end
  end

  describe ".overlay_animated_on_static" do
    it "returns an ImageList with frames from the overlay" do
      overlay = TestImageFactory.create_animated_image(16, 16, 4)
      result = Teaas::Overlayer.overlay_animated_on_static(static_img, overlay, {})
      expect(result).to be_a(Magick::ImageList)
      expect(result.length).to eq(4)
    end
  end

  describe ".overlay_static_on_animated" do
    it "returns the animated image with the static overlay composited" do
      overlay = TestImageFactory.create_static_image(8, 8)
      result = Teaas::Overlayer.overlay_static_on_animated(animated_img, overlay, {})
      expect(result).to be_a(Magick::ImageList)
      expect(result.length).to eq(3)
    end
  end

  describe ".overlay_animated_on_animated" do
    it "returns an ImageList with total_frames = lcm of both lengths" do
      img = TestImageFactory.create_animated_image(16, 16, 2)
      overlay = TestImageFactory.create_animated_image(16, 16, 3)
      result = Teaas::Overlayer.overlay_animated_on_animated(img, overlay, {})
      expect(result).to be_a(Magick::ImageList)
      expect(result.length).to eq(6)
    end
  end
end
