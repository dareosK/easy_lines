class PieceImagesController < ApplicationController
  before_action :set_piece

  # POST /pieces/:piece_id/piece_images
  def create
    # RETHINK THIS
    # raise
    # image_file = params[:image]

    # if image_file.present?
    #   # Create the image and generate the checksum
    #   image = Image.create(
    #     filename: image_file.original_filename,
    #     content_type: image_file.content_type,
    #     byte_size: image_file.size,
    #     checksum: Digest::MD5.hexdigest(image_file.tempfile.read)
    #   )

    #   # Attach the image file to the Image model
    #   image.file.attach(image_file)

    #   # Create the PieceImage association
    #   @piece.piece_images.create(image: image)

    #   redirect_to @piece, notice: "Image successfully added."
    # else
    #   redirect_to @piece, alert: "No image file uploaded."
    # end
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
end
