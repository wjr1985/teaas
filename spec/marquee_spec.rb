require 'spec_helper'

RSpec.describe Teaas::Marquee do
  describe "#marquee" do
    context "with static input" do
      let(:input) { TestImageFactory.create_static_image(16, 16) }

      it "produces 5 frames" do
        result = Teaas::Marquee.marquee(input)
        expect(result.length).to eq(5)
      end

      it "returns an ImageList" do
        result = Teaas::Marquee.marquee(input)
        expect(result).to be_a(Magick::ImageList)
      end

      it "preserves dimensions" do
        result = Teaas::Marquee.marquee(input)
        expect(result[0].columns).to eq(16)
        expect(result[0].rows).to eq(16)
      end

      it "uses vertical roller by default" do
        expect(Teaas::VerticalRoller).to receive(:roll).exactly(5).times.and_call_original
        Teaas::Marquee.marquee(input)
      end

      it "uses horizontal roller when option is set" do
        expect(Teaas::HorizontalRoller).to receive(:roll).exactly(5).times.and_call_original
        Teaas::Marquee.marquee(input, horizontal: true)
      end
    end

    context "with animated input" do
      let(:input) { TestImageFactory.create_animated_image(16, 16, 3) }

      it "preserves the frame count from the animated image" do
        result = Teaas::Marquee.marquee(input)
        expect(result.length).to eq(3)
      end

      it "returns an ImageList" do
        result = Teaas::Marquee.marquee(input)
        expect(result).to be_a(Magick::ImageList)
      end
    end

    context "with crop option on tall image" do
      let(:input) { TestImageFactory.create_tall_image(16, 32) }

      it "crops to square when crop is true" do
        result = Teaas::Marquee.marquee(input, crop: true)
        expect(result[0].columns).to eq(16)
        expect(result[0].rows).to eq(16)
      end
    end
  end

  it_behaves_like "a from_file wrapper (Image.read pattern)", Teaas::Marquee, :marquee, :marquee_from_file
end
