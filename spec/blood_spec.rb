require 'spec_helper'

RSpec.describe Teaas::Blood do
  describe "#blood" do
    let(:input) { TestImageFactory.create_static_image(16, 16) }
    let(:result) { Teaas::Blood.blood(input) }

    it_behaves_like "an overlay effect" do
      let(:input) { TestImageFactory.create_static_image(16, 16) }
      let(:result) { Teaas::Blood.blood(input) }
    end

    it "delegates to Overlayer with blood.gif" do
      expect(Teaas::Overlayer).to receive(:overlay)
      Teaas::Blood.blood(input)
    end
  end

  it_behaves_like "a from_file wrapper (ImageList pattern)", Teaas::Blood, :blood, :blood_from_file
end
