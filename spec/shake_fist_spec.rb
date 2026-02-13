require 'spec_helper'

RSpec.describe Teaas::ShakeFist do
  describe "#shake_fist" do
    let(:input) { TestImageFactory.create_static_image(16, 16) }
    let(:result) { Teaas::ShakeFist.shake_fist(input) }

    it_behaves_like "an overlay effect" do
      let(:input) { TestImageFactory.create_static_image(16, 16) }
      let(:result) { Teaas::ShakeFist.shake_fist(input) }
    end

    it "delegates to Overlayer with shake_fist.gif" do
      expect(Teaas::Overlayer).to receive(:overlay)
      Teaas::ShakeFist.shake_fist(input)
    end
  end

  it_behaves_like "a from_file wrapper (ImageList pattern)", Teaas::ShakeFist, :shake_fist, :shake_fist_from_file
end
