require 'teaas'

module TestImageFactory
  def self.create_static_image(w = 16, h = 16)
    img = Magick::ImageList.new
    pixel = Magick::Image.new(w, h) { |info| info.background_color = "red" }
    pixel.format = "PNG"
    img << pixel
    img
  end

  def self.create_animated_image(w = 16, h = 16, frames = 3)
    colors = ["red", "green", "blue", "yellow", "cyan", "magenta"]
    img = Magick::ImageList.new
    frames.times do |i|
      frame = Magick::Image.new(w, h) { |info| info.background_color = colors[i % colors.length] }
      frame.format = "GIF"
      frame.dispose = Magick::BackgroundDispose
      img << frame
    end
    img
  end

  def self.create_tall_image(w = 16, h = 32)
    create_static_image(w, h)
  end

  def self.create_wide_image(w = 32, h = 16)
    create_static_image(w, h)
  end
end

Dir[File.join(__dir__, "support", "**", "*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.after(:each) do
    File.delete("blah.gif") if File.exist?("blah.gif")
  end
end
