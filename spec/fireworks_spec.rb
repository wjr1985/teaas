require 'spec_helper'

RSpec.describe Teaas::Fireworks do
  describe "#fireworks" do
    let(:input) { TestImageFactory.create_static_image(16, 16) }
    let(:result) { Teaas::Fireworks.fireworks(input) }

    it_behaves_like "an overlay effect" do
      let(:input) { TestImageFactory.create_static_image(16, 16) }
      let(:result) { Teaas::Fireworks.fireworks(input) }
    end

    it "delegates to Overlayer with fireworks.gif" do
      expect(Teaas::Overlayer).to receive(:overlay)
      Teaas::Fireworks.fireworks(input)
    end
  end

  it_behaves_like "a from_file wrapper (ImageList pattern)", Teaas::Fireworks, :fireworks, :fireworks_from_file
end
