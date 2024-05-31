class PdfsController < ApplicationController
  before_action :set_pdf, only: %i[show edit update destroy]

  # GET /pdfs or /pdfs.json
  def index
    @pdfs = Pdf.order("id desc").all
  end

  # GET /pdfs/1 or /pdfs/1.json
  def show
  end

  # GET /pdfs/new
  def new
    @pdf = Pdf.new
  end

  # GET /pdfs/1/edit
  def edit
  end

  # POST /pdfs or /pdfs.json
  def create
    @pdf = Pdf.new(pdf_params)

    respond_to do |format|
      if @pdf.save
        format.html { redirect_to pdf_url(@pdf), notice: "Pdf was successfully created." }
        format.json { render :show, status: :created, location: @pdf }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pdf.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pdfs/1 or /pdfs/1.json
  def update
    respond_to do |format|
      if @pdf.update(pdf_params)
        format.html { redirect_to pdf_url(@pdf), notice: "Pdf was successfully updated." }
        format.json { render :show, status: :ok, location: @pdf }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pdf.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pdfs/1 or /pdfs/1.json
  def destroy
    @pdf.destroy!

    respond_to do |format|
      format.html { redirect_to pdfs_url, notice: "Pdf was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_pdf
    @pdf = Pdf.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def pdf_params
    params.fetch(:pdf, {}).permit(:source_file)
  end
end
