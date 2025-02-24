class PieceImagesController < ApplicationController
  before_action :set_piece

  # POST /pieces/:piece_id/piece_images
  def create
    @piece = Piece.find(params[:piece_id])
    @image = Image.create!(image_params)
    @image.file.attach(params[:image_file])

    @piece_image = PieceImage.create!(piece: @piece, image: @image, order: @piece.piece_images.count + 1)

    # Enqueue background job for processing image with OpenAI
    ProcessScriptImageJob.perform_later(@piece_image.id)

    redirect_to @piece
  end

  # DELETE /pieces/:piece_id/piece_images/:id
  def destroy
    @piece_image = PieceImage.find(params[:id])

    # Delete the PieceImage record
    @piece_image.destroy

    redirect_to @piece, notice: "Image successfully removed."
  end

  private
    def set_piece
      @piece = Piece.find(params[:piece_id])
    end

    def image_params
      params.require(:image).permit(:filename, :content_type, :byte_size)
    end
  end
end
