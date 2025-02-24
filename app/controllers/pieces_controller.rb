class PiecesController < ApplicationController
  before_action :set_piece, only: [:show, :edit, :update, :destroy, :simulate]

  def index
    @pieces = Piece.all
  end

  def show
    # Fetch the piece and ensure lines are ordered by the 'order' attribute in piece_lines
    @piece = Piece.includes(piece_lines: { line: :character }).find(params[:id])

    # Get the ordered lines through piece_lines
    @lines = @piece.ordered_lines
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
      images.each_with_index do |image_file, index|
        image = Image.create!(
          filename: image_file.original_filename,
          content_type: image_file.content_type,
          byte_size: image_file.size
        )
        image.file.attach(image_file)

        # Create PieceImage record
        piece_image = PieceImage.create!(piece: @piece, image: image, order: index + 1)

        puts "👉👉👉👉👉👉👉👉 MOVING INTO THE JOB"
        ProcessScriptImageJob.perform_later(piece_image.id)
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
