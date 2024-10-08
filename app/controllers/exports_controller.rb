class ExportsController < ApplicationController
  def create
    pdf = Pdf.find_by(uuid: params[:pdf_id])

    case params[:commit]
    when "Individual Cards (.zip)"
      extractor = Extractors::ButtonShy.new(pdf, params)
      exporter = Exporters::Zip.new(extractor)
      send_data exporter.data, filename: "#{pdf.filename}-cards.zip"
    when "PlayingCards.io (.pcio)"
      extractor = Extractors::ButtonShy.new(pdf, params)
      exporter = Exporters::Pcio.new(extractor, params)
      send_data exporter.data, filename: "#{pdf.filename}.pcio"
    else
      redirect_to pdf_path(pdf)
    end
  end
end
