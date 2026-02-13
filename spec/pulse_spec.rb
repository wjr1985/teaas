require 'spec_helper'

RSpec.describe Teaas::Pulse do
  describe "#pulse" do
    let(:input) { TestImageFactory.create_static_image(16, 16) }
    let(:result) { Teaas::Pulse.pulse(input) }

    it_behaves_like "a transform effect on static input", 8 do
      let(:result) { Teaas::Pulse.pulse(input) }
    end

    it "preserves dimensions" do
      expect(result[0].columns).to eq(16)
      expect(result[0].rows).to eq(16)
    end
  end

  it_behaves_like "a from_file wrapper (ImageList pattern)", Teaas::Pulse, :pulse, :pulse_from_file
end
