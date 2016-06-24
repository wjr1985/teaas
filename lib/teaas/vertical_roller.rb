module Teaas
  class VerticalRoller
    def self.roll(img, options)
      if options[:reverse]
        img.roll(0, options[:img_height] * ((options[:total_frames] - options[:frame].to_f) / options[:total_frames]))
      else
        img.roll(0, options[:img_height] * (options[:frame].to_f / options[:total_frames]))
      end
    end
  end
end
