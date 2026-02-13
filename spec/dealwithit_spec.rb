require 'spec_helper'

RSpec.describe Teaas::Dealwithit do
  describe "#dealwithit" do
    let(:input) { TestImageFactory.create_static_image(16, 16) }
    let(:result) { Teaas::Dealwithit.dealwithit(input) }

    it "produces 15 frames" do
      expect(result.length).to eq(15)
    end

    it "sets the last frame delay to 300" do
      expect(result[14].delay).to eq(300)
    end

    it "writes blah.gif to disk" do
      result
      expect(File.exist?("blah.gif")).to be true
    end

    it "returns an ImageList" do
      expect(result).to be_a(Magick::ImageList)
    end
  end

  it_behaves_like "a from_file wrapper (Image.read pattern)", Teaas::Dealwithit, :dealwithit, :dealwithit_from_file
end
