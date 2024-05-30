class Pdf < ApplicationRecord
  has_one_attached :source_file
  has_many_attached :source_pages

  after_create_commit :extract_pages

  def extract_pages
    source_file.open do |file|
      pdfinfo = `pdfinfo "#{file.path}"`
      pdfinfo.match(/Pages: +(\d+)/)[1].to_i.times do |page|
        source_page = Vips::Image.pdfload(file.path, page: page, n: 1, dpi: 150)
        source_pages.attach(io: StringIO.new(source_page.write_to_buffer(".jpg")), filename: "page-#{page}.jpg")
      end
    end
  end
end
