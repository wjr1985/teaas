require 'spec_helper'

RSpec.describe Teaas::Spin do
  describe "#spin" do
    context "with static input" do
      let(:input) { TestImageFactory.create_static_image(16, 16) }
      let(:result) { Teaas::Spin.spin(input) }

      it_behaves_like "a transform effect on static input", 4 do
        let(:result) { Teaas::Spin.spin(input) }
      end

      it "produces square frames based on the longest side" do
        tall = TestImageFactory.create_tall_image(16, 32)
        r = Teaas::Spin.spin(tall)
        expect(r[0].columns).to eq(32)
        expect(r[0].rows).to eq(32)
      end
    end

    context "with animated input" do
      let(:input) { TestImageFactory.create_animated_image(16, 16, 3) }
      let(:result) { Teaas::Spin.spin(input) }

      it "produces frames * rotations frames" do
        expect(result.length).to eq(12)
      end

      it "returns an ImageList" do
        expect(result).to be_a(Magick::ImageList)
      end
    end

    context "with custom rotations" do
      let(:input) { TestImageFactory.create_static_image(16, 16) }

      it "uses legacy path and produces the specified number of frames" do
        result = Teaas::Spin.spin(input, rotations: 6)
        expect(result.length).to eq(6)
      end
    end

    context "with counterclockwise option" do
      let(:input) { TestImageFactory.create_static_image(16, 16) }

      it "still produces 4 frames" do
        result = Teaas::Spin.spin(input, counterclockwise: true)
        expect(result.length).to eq(4)
      end
    end
  end

  it_behaves_like "a from_file wrapper (ImageList pattern)", Teaas::Spin, :spin, :spin_from_file
end
