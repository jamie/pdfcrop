class ExportsController < ApplicationController
  def create
    pdf = Pdf.find_by(uuid: params[:pdf_id])

    case params[:commit]
    when "Individual Cards (.zip)"
      exporter = Exporters::Zip.new(pdf, params)
      send_data exporter.data, filename: "#{pdf.filename}-cards.zip"
    else
      redirect_to pdf_path(pdf)
    end
  end
end
