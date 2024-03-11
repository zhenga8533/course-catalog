class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!, only: [:new, :create, :fetch_classes, :edit, :update, :destroy]
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses or /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1 or /courses/1.json
  def show
    @course = Course.find(params[:id])
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: "Course was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # POST /courses/fetch_classes
  def fetch_classes
    search_params = {
      q: params[:q],
      campus: params[:campus],
      term: params[:term],
      academic_career: params[:academic_career],
      subject: params[:subject],
      class_attribute: params[:class_attribute]
    }.reject { |_, v| v.blank? }
    
    CourseService.fetch_classes(search_params)
    redirect_to courses_url, notice: "Classes fetched successfully."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = Course.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def course_params
    params.require(:course).permit(:term, :title, :description, :subject, :catalog_number, :campus, :course_id, :required_graders, :created_at, :updated_at)
  end

  def authenticate_admin!
    unless user_signed_in? && current_user.verified && current_user.role == "admin"
      redirect_to root_path, alert: "Access denied."
    end
  end
end
