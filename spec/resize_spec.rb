require 'spec_helper'

RSpec.describe Teaas::Resize do
  describe ".resize" do
    it "resizes an ImageList to the specified dimensions" do
      img = TestImageFactory.create_static_image(32, 32)
      result = Teaas::Resize.resize(img, "16x16")
      expect(result[0].columns).to eq(16)
      expect(result[0].rows).to eq(16)
    end

    it "wraps a single Image into an ImageList" do
      single = Magick::Image.new(32, 32)
      result = Teaas::Resize.resize(single, "16x16")
      expect(result).to be_a(Magick::ImageList)
      expect(result[0].columns).to eq(16)
    end

    it "keeps original size when resize is nil" do
      img = TestImageFactory.create_static_image(20, 20)
      result = Teaas::Resize.resize(img, nil)
      expect(result[0].columns).to eq(20)
      expect(result[0].rows).to eq(20)
    end

    it "keeps original size when resize is empty string" do
      img = TestImageFactory.create_static_image(20, 20)
      result = Teaas::Resize.resize(img, "")
      expect(result[0].columns).to eq(20)
      expect(result[0].rows).to eq(20)
    end

    it "uses sample! when sample option is true" do
      img = TestImageFactory.create_static_image(32, 32)
      result = Teaas::Resize.resize(img, "16x16", sample: true)
      expect(result[0].columns).to eq(16)
      expect(result[0].rows).to eq(16)
    end

    it "resizes all frames of an animated image" do
      img = TestImageFactory.create_animated_image(32, 32, 3)
      result = Teaas::Resize.resize(img, "16x16")
      result.each do |frame|
        expect(frame.columns).to eq(16)
        expect(frame.rows).to eq(16)
      end
    end
  end

  describe ".resize_from_file" do
    it "loads the file and delegates to resize" do
      img = double("ImageList")
      expect(Magick::ImageList).to receive(:new).and_return(img)
      expect(img).to receive(:read)
      expect(Teaas::Resize).to receive(:resize).with(img, "16x16", {})

      Teaas::Resize.resize_from_file("test.png", "16x16")
    end
  end
end
