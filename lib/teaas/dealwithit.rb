module Teaas
  class Dealwithit
    def self.dealwithit(original_img, options = {})
      img = Teaas::Helper.prepare_for_animation(original_img)
      img_height = img.rows
      glasses = Magick::Image.read(Teaas.root + "/img/dealwithit.png")[0]
      glasses.resize_to_fit!(img.columns, img_height)

      animated_glasses = Magick::ImageList.new

      15.times do |i|
        glasses_over_image = img.copy
        glasses_over_image = glasses_over_image.composite(
          glasses,
          Magick::NorthGravity,
          0,
          ((img_height/3) * (i.to_f/10)),
          Magick::OverCompositeOp,
        )

        if i >= 14
          glasses_over_image.delay = 300
        end

        animated_glasses << glasses_over_image
      end

      animated_glasses.write("blah.gif")
    end

    def self.dealwithit_from_file(path, options = {})
      img = Magick::Image.read(path)
      dealwithit(img ,options)
    end
  end
end
