class SectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_course, only: [:show, :new, :create, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :section_not_found

  def index
    @sections = Section.all
    @sections_not_having_graders = Section.where.not(id: User.pluck(:section_id).compact)
    @sections_having_graders = Section.where(id: User.pluck(:section_id).compact)
  end

  def show
    @section = @course.sections.find(params[:id])
  end
  
  def new
    @section = @course.sections.build
  end

  def create
    @section = @course.sections.build(section_params)

    respond_to do |format|
      if @section.save
        format.html { redirect_to @section, notice: "Section was successfully created." }
        format.json { render :show, status: :created, location: @section }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @section = @course.sections.find(params[:id])
  end

  def update
    @section = @course.sections.find(params[:id])

    respond_to do |format|
      if @section.update(section_params)
        format.html { redirect_to @course, notice: "Section was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end  

  def destroy
    @section = @course.sections.find(params[:id])
    @section.destroy
    redirect_to @course, notice: 'Section was successfully deleted.'
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def section_params
    params.require(:section).permit(:section_number, :component, :instruction_mode, :building_description, :required_graders, :monday, :tuesday, :wednesday, :thursday, 
      :friday, :saturday, :sunday, :start_time, :end_time, :start_date, :end_date, user_ids: [])
  end

  def authenticate_admin!
    unless user_signed_in? && current_user.verified && current_user.role == "admin"
      redirect_to root_path, alert: "Access denied."
    end
  end

  def section_not_found
    flash[:alert] = "Section not found."
    redirect_to courses_path
  end
end
