class PiecesController < ApplicationController
  before_action :set_piece, only: [:show, :edit, :update, :destroy, :simulate]

  def index
    @pieces = Piece.all
  end

  def show
    # @characters = @piece.characters
    # @lines = @piece.lines.order(:order)
  end

  def new
    @piece = Piece.new
  end

  def create
    @piece = Piece.new(piece_params)
    @piece.user = current_user

    if @piece.save!
      # Handle image uploads
      images = params[:piece][:images].reject { |image_file| image_file.blank? || image_file.tempfile.nil? }
      images.each do |image_file|
        image = Image.create(
          filename: image_file.original_filename,
          content_type: image_file.content_type,
          byte_size: image_file.size
          # checksum: image_file.checksum
        )
        # Attach the image file to the Image model
        image.file.attach(image_file)

        # Create PieceImage record to associate Piece and Image.
        # If you are creating a Piece, it is logical that the image you
        # are uploading with it is the first is the order. This logic
        # should be different in the PieceImageController#create. There,
        # you should first check the amount of images already linked to a given piece
        PieceImage.create(piece: @piece, image: image, order: 1)
      end
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @piece.update(piece_params)
      redirect_to @piece, notice: "Piece updated successfully!"
    else
      render :edit
    end
  end

  def destroy
    @piece.destroy
    redirect_to pieces_url, notice: "Piece deleted successfully!"
  end

  def simulate
    # Logic for simulating the scene
  end

  private

  def set_piece
    @piece = Piece.find(params[:id])
  end

  def piece_params
    params.require(:piece).permit(:title, :role)
  end
end
