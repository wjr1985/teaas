require 'spec_helper'

RSpec.describe Teaas::Fire do
  describe "#fire" do
    let(:input) { TestImageFactory.create_static_image(16, 16) }
    let(:result) { Teaas::Fire.fire(input) }

    it_behaves_like "an overlay effect" do
      let(:input) { TestImageFactory.create_static_image(16, 16) }
      let(:result) { Teaas::Fire.fire(input) }
    end

    it "delegates to Overlayer with fire.gif" do
      expect(Teaas::Overlayer).to receive(:overlay)
      Teaas::Fire.fire(input)
    end
  end

  it_behaves_like "a from_file wrapper (ImageList pattern)", Teaas::Fire, :fire, :fire_from_file
end
