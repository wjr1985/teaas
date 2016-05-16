module Teaas
  class Overlayer
    def self.overlay(original_img, overlay_img, options={})
      if options[:whitelisted_animation]
        overlay_animated_on_animated(original_img, overlay_img)
      else
        overlay_animated_on_static(original_img, overlay_img)
      end

    end

    def self.overlay_animated_on_animated(img, overlay_img)
      puts "DATA DUMP"
      puts img.delay
      puts img.ticks_per_second
      puts img.length
      puts "*"*20
      puts overlay_img.delay
      puts overlay_img.ticks_per_second
      puts overlay_img.length

      overlay_img.each do |image|
        image.resize_to_fit!(img.columns, img.rows)
      end

      new_image = img
      new_overlay_img = overlay_img

      total_frames = img.length * overlay_img.length

      ((total_frames / img.length)-1).times do
        new_image += img
      end

      ((total_frames / overlay_img.length)-1).times do
        new_overlay_img += overlay_img
      end
      new_image = new_image.composite_layers(new_overlay_img)

      new_image
    end

    def self.overlay_animated_on_static(original_img, overlay_img)
      image = Magick::ImageList.new
      img = Teaas::Helper.prepare_for_animation(original_img)
      overlay_img.each do |image|
        image.resize_to_fit!(img.columns, img.rows)
      end
      image << img

      image = image.composite_layers(overlay_img)

      image
    end
  end
end
