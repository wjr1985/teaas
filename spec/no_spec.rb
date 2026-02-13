require 'spec_helper'

RSpec.describe Teaas::No do
  describe "#no" do
    let(:input) { TestImageFactory.create_animated_image(16, 16, 3) }
    let(:result) { Teaas::No.no(input) }

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

    it "uses static_on_animated mode with CenterGravity" do
      expect(Teaas::Overlayer).to receive(:overlay).with(
        input,
        anything,
        hash_including(static_on_animated: true, gravity: Magick::CenterGravity)
      )
      Teaas::No.no(input)
    end
  end

  it_behaves_like "a from_file wrapper (ImageList pattern)", Teaas::No, :no, :no_from_file
end
