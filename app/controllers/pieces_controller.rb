class PiecesController < ApplicationController
  before_action :set_piece, only: [:show, :edit, :update, :destroy, :simulate]

  def index
    @pieces = Piece.all
  end

  def show
    @characters = @piece.characters
    @lines = @piece.lines.order(:order)
  end

  def new
    @piece = Piece.new
  end

  def create
    @piece = Piece.new(piece_params)
    if @piece.save
      redirect_to @piece, notice: "Piece created successfully!"
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
    params.require(:piece).permit(:title, :role, images: [])
  end
end
