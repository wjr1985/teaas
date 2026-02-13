require 'spec_helper'

RSpec.describe Teaas::Tears do
  describe "#tears" do
    let(:input) { TestImageFactory.create_static_image(16, 16) }
    let(:result) { Teaas::Tears.tears(input) }

    it_behaves_like "an overlay effect" do
      let(:input) { TestImageFactory.create_static_image(16, 16) }
      let(:result) { Teaas::Tears.tears(input) }
    end

    it "delegates to Overlayer with tears2.gif" do
      expect(Teaas::Overlayer).to receive(:overlay)
      Teaas::Tears.tears(input)
    end
  end

  it_behaves_like "a from_file wrapper (ImageList pattern)", Teaas::Tears, :tears, :tears_from_file
end
