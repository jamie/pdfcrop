class Exporters::Zip
  def initialize(pdf, params)
    @pdf = pdf
    read_params(params)
  end

  def data
    content = nil
    Tempfile.create do |tempfile|
      Zip::File.open(tempfile.path, create: true) do |zipfile|
        i = 1
        each_front_jpg_buttonshy do |jpg|
          zipfile.get_output_stream("front-#{i}.jpg") { _1.write(jpg) }
          i += 1
        end

        i = 1
        each_back_jpg_buttonshy do |jpg|
          zipfile.get_output_stream("back-#{i}.jpg") { _1.write(jpg) }
          i += 1
        end
      end

      content = File.open(tempfile.path).read
    end
    content
  end

  private

  def read_params(params)
    @ignore_first = params[:ignoreFirst].to_i
    @cards_in_row = params[:cardsX].to_i
    @cards_in_col = params[:cardsY].to_i

    @card_size = [params[:cardX], params[:cardY]].map(&:to_i)
    @margin = OpenStruct.new({x: params[:marginX], y: params[:marginY]}.transform_values(&:to_i))
    @padding = OpenStruct.new({x: params[:paddingX], y: params[:paddingY]}.transform_values(&:to_i))
  end

  def crop_points
    @crop_points ||= begin
      out = []
      width, height = @card_size

      @cards_in_col.times do |row_index|
        @cards_in_row.times do |col_index|
          left = @margin.x + (width + @padding.x) * col_index
          top = @margin.y + (height + @padding.y) * row_index

          out << [left, top, width, height]
        end
      end
      out
    end
  end

  def pages_to_extract
    @pdf.source_pages[@ignore_first...]
  end

  def each_front_jpg_buttonshy
    pages_to_extract.in_groups_of(2) do |fronts, backs|
      fronts.open do |tempfile|
        page = Vips::Image.new_from_file(tempfile.path)

        [
          0,1,2,
          3,4,5
        ].each do |i|
          yield page.crop(*crop_points[i]).write_to_buffer(".jpg")
        end
      end
    end
  end

  def each_back_jpg_buttonshy
    debugger if @ignoreFirst == 0

    pages_to_extract.in_groups_of(2) do |fronts, backs|
      backs.open do |tempfile|
        page = Vips::Image.new_from_file(tempfile.path)

        [
          2,1,0,
          5,4,3
        ].each do |i|
          yield page.crop(*crop_points[i]).write_to_buffer(".jpg")
        end
      end
    end
  end
end
