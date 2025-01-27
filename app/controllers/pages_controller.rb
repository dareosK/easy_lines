class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if user_signed_in?
      redirect_to dashboard_path # Replace with the actual dashboard path
    else
      redirect_to new_user_registration_path
    end
  end

  def dashboard
    @pieces = current_user.pieces
  end
end
