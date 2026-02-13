RSpec.shared_examples "a from_file wrapper (ImageList pattern)" do |klass, method_name, from_file_method|
  describe "##{from_file_method}" do
    it "loads the file and delegates to #{method_name}" do
      img = double("ImageList")
      expect(Magick::ImageList).to receive(:new).and_return(img)
      expect(img).to receive(:read).and_return([Magick::Image.new(16, 16)])
      expect(klass).to receive(method_name)

      klass.send(from_file_method, "test.png")
    end
  end
end

RSpec.shared_examples "a from_file wrapper (Image.read pattern)" do |klass, method_name, from_file_method|
  describe "##{from_file_method}" do
    it "loads the file and delegates to #{method_name}" do
      image = [Magick::Image.new(16, 16)]
      expect(Magick::Image).to receive(:read).with("test.png").and_return(image)
      expect(klass).to receive(method_name)

      klass.send(from_file_method, "test.png")
    end
  end
end

RSpec.shared_examples "an overlay effect" do
  it "returns an ImageList" do
    expect(result).to be_a(Magick::ImageList)
  end

  it "has multiple frames" do
    expect(result.length).to be > 1
  end

  it "preserves the input dimensions" do
    expect(result[0].columns).to be_within(2).of(input.columns)
    expect(result[0].rows).to be_within(2).of(input.rows)
  end
end

RSpec.shared_examples "a transform effect on static input" do |expected_frames|
  it "returns an ImageList" do
    expect(result).to be_a(Magick::ImageList)
  end

  it "produces #{expected_frames} frames" do
    expect(result.length).to eq(expected_frames)
  end
end
