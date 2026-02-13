require 'spec_helper'

RSpec.describe Teaas::Turboize do
  let(:animated_image) { TestImageFactory.create_animated_image(16, 16, 3) }

  describe "#turbo" do
    it "does not resize when resize is empty" do
      expect(Teaas::Resize).not_to receive(:resize)
      Teaas::Turboize.turbo(animated_image, '')
    end

    it "resizes when resize is specified" do
      result = Teaas::Turboize.turbo(animated_image, "8x8")
      expect(result).to be_a(Array)
    end

    it "uses default speeds when no speeds specified" do
      result = Teaas::Turboize.turbo(animated_image, "")
      expect(result.length).to eq(6)
    end

    it "uses custom speeds when specified" do
      result = Teaas::Turboize.turbo(animated_image, "", [1, 3, 100])
      expect(result.length).to eq(3)
    end

    it "returns an array of GIF blobs" do
      result = Teaas::Turboize.turbo(animated_image, "")
      result.each do |blob|
        expect(blob[0..2]).to eq("GIF")
      end
    end

    it "uses default speeds when speeds is nil" do
      result = Teaas::Turboize.turbo(animated_image, "", nil)
      expect(result.length).to eq(6)
    end
  end

  describe "#turboize_individual_image" do
    it "sets ticks_per_second with the value passed in" do
      img = TestImageFactory.create_animated_image(16, 16, 2)
      expect {
        Teaas::Turboize.turboize_individual_image(img, 20)
      }.to change { img.ticks_per_second }.to(20)
    end

    it "sets delay to 1 by default" do
      img = TestImageFactory.create_animated_image(16, 16, 2)
      Teaas::Turboize.turboize_individual_image(img, 10)
      expect(img.delay).to eq(1)
    end

    it "sets custom delay when option provided" do
      img = TestImageFactory.create_animated_image(16, 16, 2)
      Teaas::Turboize.turboize_individual_image(img, 10, delay: 5)
      expect(img.delay).to eq(5)
    end

    it "sets iterations to 0 (loop forever)" do
      img = TestImageFactory.create_animated_image(16, 16, 2)
      Teaas::Turboize.turboize_individual_image(img, 10)
      expect(img.iterations).to eq(0)
    end
  end

  describe "#turbo_from_file" do
    it "loads the file and delegates to turbo" do
      image = double("ImageList")
      expect(Magick::ImageList).to receive(:new).and_return(image)
      expect(image).to receive(:read)
      expect(Teaas::Turboize).to receive(:turbo).with(image, "8x8", [1, 2], {})

      Teaas::Turboize.turbo_from_file("test.gif", "8x8", [1, 2])
    end
  end
end
