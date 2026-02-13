require 'spec_helper'

RSpec.describe Teaas::Mirror do
  describe "#mirror" do
    context "with static input" do
      let(:input) { TestImageFactory.create_static_image(16, 16) }

      it "returns a single Image (flop)" do
        result = Teaas::Mirror.mirror(input)
        expect(result).to be_a(Magick::Image)
      end

      it "preserves dimensions" do
        result = Teaas::Mirror.mirror(input)
        expect(result.columns).to eq(16)
        expect(result.rows).to eq(16)
      end
    end

    context "with animated input" do
      let(:input) { TestImageFactory.create_animated_image(16, 16, 3) }

      it "returns an ImageList" do
        result = Teaas::Mirror.mirror(input)
        expect(result).to be_a(Magick::ImageList)
      end

      it "preserves the frame count" do
        result = Teaas::Mirror.mirror(input)
        expect(result.length).to eq(3)
      end

      it "preserves dimensions" do
        result = Teaas::Mirror.mirror(input)
        expect(result[0].columns).to eq(16)
        expect(result[0].rows).to eq(16)
      end
    end
  end

  it_behaves_like "a from_file wrapper (Image.read pattern)", Teaas::Mirror, :mirror, :mirror_from_file
end
