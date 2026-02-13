require 'spec_helper'

RSpec.describe Teaas::Heart do
  describe "#heart" do
    let(:input) { TestImageFactory.create_static_image(16, 16) }
    let(:result) { Teaas::Heart.heart(input) }

    it_behaves_like "an overlay effect" do
      let(:input) { TestImageFactory.create_static_image(16, 16) }
      let(:result) { Teaas::Heart.heart(input) }
    end

    it "delegates to Overlayer with heart.gif" do
      expect(Teaas::Overlayer).to receive(:overlay)
      Teaas::Heart.heart(input)
    end
  end

  it_behaves_like "a from_file wrapper (ImageList pattern)", Teaas::Heart, :heart, :heart_from_file
end
