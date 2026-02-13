require 'spec_helper'

RSpec.describe Teaas::Got do
  describe "#got" do
    let(:input) { TestImageFactory.create_static_image(16, 16) }
    let(:result) { Teaas::Got.got(input) }

    it "returns an ImageList" do
      expect(result).to be_a(Magick::ImageList)
    end

    it "has multiple frames" do
      expect(result.length).to be > 1
    end

    it "calls Overlayer twice (fire then blood with whitelisted_animation)" do
      expect(Teaas::Overlayer).to receive(:overlay).with(input, anything).and_call_original
      expect(Teaas::Overlayer).to receive(:overlay).with(anything, anything, hash_including(whitelisted_animation: true)).and_call_original
      Teaas::Got.got(input)
    end
  end

  it_behaves_like "a from_file wrapper (ImageList pattern)", Teaas::Got, :got, :got_from_file
end
