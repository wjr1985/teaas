module Teaas
  class Overlayer
    def self.overlay(original_img, overlay_img, options={})
      if options[:whitelisted_animation]
        overlay_animated_on_animated(original_img, overlay_img, options)
      elsif options[:static_on_animated]
        overlay_static_on_animated(original_img, overlay_img, options)
      else
        overlay_animated_on_static(original_img, overlay_img, options={})
      end
    end

    def self.overlay_static_on_animated(img, overlay_img, options)
      overlay_resize = options[:overlay_resize] || 1
      image = Magick::ImageList.new
      overlay_img.each do |image|
        image.resize_to_fit!(img.columns * overlay_resize, img.rows * overlay_resize)
      end
      gravity = options[:gravity] || Magick::SouthGravity

      overlay_img.gravity = gravity
      img.each do |i|
        i.composite!(overlay_img, gravity, Magick::OverCompositeOp)
      end

      img
    end

    def self.overlay_animated_on_animated(img, overlay_img, options)
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
      new_image.gravity = options[:gravity] ? options[:gravity] : Magick::SouthGravity
      new_image = new_image.composite_layers(new_overlay_img)

      new_image
    end

    def self.overlay_animated_on_static(original_img, overlay_img, options)
      image = Magick::ImageList.new
      img = Teaas::Helper.prepare_for_animation(original_img)
      overlay_img.each do |image|
        image.resize_to_fit!(img.columns, img.rows)
      end
      image << img

      image.gravity = options[:gravity] ? options[:gravity] : Magick::SouthGravity
      image = image.composite_layers(overlay_img)

      image
    end
  end
end
