require 'spec_helper'

RSpec.describe Teaas::Reverse do
  describe "#reverse" do
    context "with animated input" do
      it "reverses the frame order" do
        input = TestImageFactory.create_animated_image(16, 16, 3)
        # Frames are red, green, blue - reversed should be blue, green, red
        result = Teaas::Reverse.reverse(input)
        expect(result).to be_a(Magick::ImageList)
        expect(result.length).to eq(3)

        # Verify the first pixel of reversed frame 0 matches original frame 2
        original_last_pixel = input[2].pixel_color(0, 0)
        reversed_first_pixel = result[0].pixel_color(0, 0)
        expect(reversed_first_pixel).to eq(original_last_pixel)
      end
    end

    context "with static input" do
      it "returns the input unchanged" do
        input = TestImageFactory.create_static_image(16, 16)
        result = Teaas::Reverse.reverse(input)
        expect(result).to eq(input)
      end
    end
  end

  it_behaves_like "a from_file wrapper (Image.read pattern)", Teaas::Reverse, :reverse, :reverse_from_file
end
