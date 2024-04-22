class ProfilesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_profile, only: [:show]
    rescue_from ActiveRecord::RecordNotFound, with: :profile_not_found
  
    # GET /profiles/:id
    def show
    end
  
    private
  
    def set_profile
      @profile = User.find(params[:id])
    end

    def profile_not_found
      flash[:alert] = "Profile not found."
      redirect_to root_path
    end
 end
