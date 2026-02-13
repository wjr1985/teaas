require 'spec_helper'

RSpec.describe Teaas::Wait do
  describe "#wait" do
    let(:input) { TestImageFactory.create_static_image(16, 16) }
    let(:result) { Teaas::Wait.wait(input) }

    it_behaves_like "an overlay effect" do
      let(:input) { TestImageFactory.create_static_image(16, 16) }
      let(:result) { Teaas::Wait.wait(input) }
    end

    it "delegates to Overlayer with wait.gif" do
      expect(Teaas::Overlayer).to receive(:overlay)
      Teaas::Wait.wait(input)
    end
  end

  it_behaves_like "a from_file wrapper (ImageList pattern)", Teaas::Wait, :wait, :wait_from_file
end
