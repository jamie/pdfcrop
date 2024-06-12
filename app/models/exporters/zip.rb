class Exporters::Zip
  def initialize(source)
    @source = source
  end

  def data
    stringio = Zip::OutputStream.write_buffer do |zipfile|
      @source.each_front_jpg do |jpg, i|
        zipfile.put_next_entry("front-#{i}.jpg")
        zipfile.write(jpg)
      end

      @source.each_back_jpg do |jpg, i|
        zipfile.put_next_entry("back-#{i}.jpg")
        zipfile.write(jpg)
      end
    end

    stringio.string
  end
end
