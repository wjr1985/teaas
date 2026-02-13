require 'spec_helper'

RSpec.describe Teaas::Intensify do
  describe "#intensify" do
    let(:input) { TestImageFactory.create_static_image(16, 16) }
    let(:result) { Teaas::Intensify.intensify(input) }

    it_behaves_like "a transform effect on static input", 7 do
      let(:result) { Teaas::Intensify.intensify(input) }
    end

    it "preserves dimensions" do
      expect(result[0].columns).to eq(16)
      expect(result[0].rows).to eq(16)
    end
  end

  it_behaves_like "a from_file wrapper (Image.read pattern)", Teaas::Intensify, :intensify, :intensify_from_file
end
