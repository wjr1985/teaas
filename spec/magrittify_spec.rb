require 'spec_helper'

RSpec.describe Teaas::Magrittify do
  describe "#magrittify" do
    let(:input) { TestImageFactory.create_animated_image(16, 16, 3) }
    let(:result) { Teaas::Magrittify.magrittify(input) }

    it "returns an ImageList" do
      expect(result).to be_a(Magick::ImageList)
    end

    it "preserves the frame count from the animated input" do
      expect(result.length).to eq(3)
    end

    it "preserves the input dimensions" do
      expect(result[0].columns).to eq(16)
      expect(result[0].rows).to eq(16)
    end

    it "uses static_on_animated mode with CenterGravity and overlay_resize 0.6" do
      expect(Teaas::Overlayer).to receive(:overlay).with(
        input,
        anything,
        hash_including(static_on_animated: true, gravity: Magick::CenterGravity, overlay_resize: 0.6)
      )
      Teaas::Magrittify.magrittify(input)
    end
  end

  it_behaves_like "a from_file wrapper (ImageList pattern)", Teaas::Magrittify, :magrittify, :magrittify_from_file
end
