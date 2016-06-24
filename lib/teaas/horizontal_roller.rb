module Teaas
  class HorizontalRoller
    def self.roll(img, options)
      if options[:reverse]
        img.roll(options[:img_width] * ((options[:total_frames] - options[:frame].to_f) / options[:total_frames]), 0)
      else
        img.roll(options[:img_width] * (options[:frame].to_f / options[:total_frames]), 0)
      end
    end
  end
end
