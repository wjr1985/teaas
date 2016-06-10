module Teaas
  class Resize
    def self.resize(img, resize, options={})
      img = img.coalesce
      img.each do |frame|
        frame.change_geometry(resize) do |cols, rows, i|
          if options[:sample]
            i.sample!(cols, rows)
          else
            i.resize!(cols, rows)
          end
        end
      end

      img
    end

    def self.resize_from_file(path, resize, options={})
      img = Magick::ImageList.new
      img.read(path)

      resize(img, resize, options)
    end
  end
end
