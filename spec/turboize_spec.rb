require 'spec_helper'

RSpec.describe Teaas::Turboize do
  describe "#turbo" do
    before(:each) do
      @animated_image = Magick::ImageList.new

      @animated_image.from_blob(Base64.decode64("R0lGODlhDwAPAPIGAAAAAP//AP/KAP/YAP/lAP/xAP///wAAACH5BAUSAAYA\nIf8LTkVUU0NBUEUyLjADAQAAACwAAAAADwAPAAADTWiq0L3QtFACEQ+CWkMY\nArYAXkkRAwgw3eQ1Ilm6QaNuplmgmJxTuxuhU+LwYAOCYwlbAQTJoZSAGjih\n1GxVxICmvqGV5hkKiyOSZSQBACH5BAUSAAYALAQABAAKAAcAAAMUaBHWMy1K\nCUCsM2u5SiggAVVkKSQAOw==\n"))
    end

    it "does not resize when resize is false" do
      expect_any_instance_of(Magick::Image).to_not receive(:change_geometry)

      Teaas::Turboize.turbo(@animated_image, false)
    end

    it "resizes when resize is true" do
      pending("Need to figure out a way to allow all instances of Magick::Image to receive change_geometry, instead of just one instance")
      expect_any_instance_of(Magick::Image).to receive(:change_geometry).at_least(:once)

      Teaas::Turboize.turbo(@animated_image, true)
    end

    it "uses default speeds when no speeds specified" do
      [2, 5, 10, 20, 30, 40].each do |i|
        expect(Teaas::Turboize).to receive(:turboize_individual_image).with(@animated_image, i).and_call_original
      end

      Teaas::Turboize.turbo(@animated_image, false)
    end
    it "uses custom speeds when specified" do
      [1, 3, 100].each do |i|
        expect(Teaas::Turboize).to receive(:turboize_individual_image).with(@animated_image, i).and_call_original
      end

      Teaas::Turboize.turbo(@animated_image, false, [1, 3, 100])
    end
  end

  describe "#turbo_from_file" do
    it "calls turbo with parameters passed in" do
      image = double()
      expect(image).to receive(:read)
      expect(Magick::ImageList).to receive(:new).and_return(image)

      expect(Teaas::Turboize).to receive(:turbo).with(image, false, [1, 2, 3, 4])

      Teaas::Turboize.turbo_from_file("hello.gif", false, [1, 2, 3, 4])
    end
  end

  describe "#turboize_individual_image" do
    it "sets ticks_per_second with the value passed in" do
      animated_image = Magick::ImageList.new
      animated_image.from_blob(Base64.decode64("R0lGODlhDwAPAPIGAAAAAP//AP/KAP/YAP/lAP/xAP///wAAACH5BAUSAAYA\nIf8LTkVUU0NBUEUyLjADAQAAACwAAAAADwAPAAADTWiq0L3QtFACEQ+CWkMY\nArYAXkkRAwgw3eQ1Ilm6QaNuplmgmJxTuxuhU+LwYAOCYwlbAQTJoZSAGjih\n1GxVxICmvqGV5hkKiyOSZSQBACH5BAUSAAYALAQABAAKAAcAAAMUaBHWMy1K\nCUCsM2u5SiggAVVkKSQAOw==\n"))

      expect do
        Teaas::Turboize.turboize_individual_image(animated_image, 20)
      end.to change {animated_image.ticks_per_second}.to(20)
    end
  end
end
