require 'spec_helper'

RSpec.describe Teaas::Turboize do
  describe "#spin" do
    it "rotates the image" do
      static_image = Magick::ImageList.new

      static_image.from_blob(Base64.decode64("iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAABGdBTUEAAK/I\nNwWK6QAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3Cc\nulE8AAACIlBMVEX////////66+nyv7jzwr3aaWbEEg2wCgORDwdmBwP79fTY\nh37BJBNxDAbz39y8QDPVa2SgEgp/DAXx3dmwLSG6HRBxBgH69POwPzSEBADB\nfnvjtLKOAgD67u2WAAD22NeaAADxsq6lBQfOMSa4EBWtEwnLGyCcEArYJCub\nDwnbNTelBQKRDwqODAmkBRCcCQiWDAaYEQygFA+mFhGvGha6Hh3HKCjSNTWi\nIhrBCADSKRfssay0LSScCgCNEAmsAAC2CQC7DwDFGQnwrKaODgeoAgCzDwC2\nDgC1BwDHOzHPRzrEIBGPDQaiBACvEQCxEACyDQCxEAfUfXazGQ+sDQOqDAOf\nCQGOAACnEQCsEgCuDwCoBQDVg3mbAAChBgCVBQCFBgCVHx2JAQCfDQClDQCj\nDADDWUzrlo/ecGifDQaVBACQBgCIBQC2JR6MBQGGAACYFQzEZVjRUEjHKiHH\nKyGfDwiIBACBBgCNBAHiiIO8OTOuWFTUn5u+NS60CwG1EQe2EQidCwSBBACB\nCwKTCwTtt7X1xcL7y8fIWl+TAACcCAGfCAGmCACcBwB/CAGHEQSWEQi+Ly/n\nY1vgTUatEBeaBQGWBgCOBgCFBQCRBgKRDwaEEQGUEwilDQ3MJyLGICCiBg6X\nBwGPBgCHBQCRCAWyDhK+FRmZFAqJEgOXDQunDg2vChKfBgqUBgCIBwCUCwez\nERTAGBzOHiTZJCusHhf///9SfnC6AAAAOXRSTlMAAzaRrqiprHgNPs3+n0rz\n/v3kV/j+5jP32K/+ykm6mqiflqyDuXG8XoZLEabp6NrNwLGgkIBvYRUslQHM\nAAAAAWJLR0QAiAUdSAAAAAd0SU1FB98MEgovDXFmt0kAAADeSURBVBjTY2DA\nDhiZmFlY2dg5OKF8Lm4eSytrG1s7Xgifj9/ewdHJWUDQRQjMFxZxdXP38PTy\nFvURA/HFJXz9/AMCg4JDQsMkQQJS4RGRUdEx0rFx8QkyQL5sYlJySmpaekZm\nVnaOHFBAPjcvv6CwqLiktKy8QgEooFhZVV1TW1ff0NjU3KIEFFBubWvv6Ozq\n7unt65+gAhRQnThp8pSp06bPmDlr9hw1oID63HnzFyxctHjJ0mXLV2gABTRX\nrlq9Zu269Rs2btq8RQsooK2jq6dvYGhkbGJqZm6B6W8AY30/o8A8ZoIAAAAl\ndEVYdGRhdGU6Y3JlYXRlADIwMTUtMTItMThUMTA6NDc6MTYtMDY6MDBH1MFc\nAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDE1LTEyLTE4VDEwOjQ3OjEzLTA2OjAw\nZLFWRwAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAAA\nSUVORK5CYII=\n"))
      flattened_static_image = static_image.flatten_images
      spinny_image = double()

      expect(Magick::ImageList).to receive(:new).and_return(spinny_image)

      expect(static_image).to receive(:flatten_images).and_return(flattened_static_image)

      expect(flattened_static_image).to receive(:rotate).with(90).and_call_original
      expect(flattened_static_image).to receive(:rotate).with(180).and_call_original
      expect(flattened_static_image).to receive(:rotate).with(270).and_call_original

      expect(spinny_image).to receive(:<<).exactly(4).times

      Teaas::Spin.spin(static_image)
    end
  end

  describe("#spin_from_file") do
    it "calls spin with image" do
      image = double()
      expect(image).to receive(:read).and_return([Magick::Image.new(32, 32)])

      expect(Magick::ImageList).to receive(:new).and_return(image)

      expect(Teaas::Spin).to receive(:spin).with(image)
      Teaas::Spin.spin_from_file("hello.png")
    end
  end
end
