class StudentApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_student_application, only: [:show, :edit, :update, :destroy]
  before_action :authorize_access, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :application_not_found

  def index
    @student_applications = current_user.admin? ? StudentApplication.all : StudentApplication.where(user_id: current_user.id)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @student_applications }
    end
  end

  def show
    @student_application = StudentApplication.find(params[:id])
    user = @student_application.user
    @recommendations = Recommendation.where(student_email: user.email, course_id: @student_application.course_id)
    @sections = Course.find(@student_application.course_id).sections
  end

  def new
    @student_application = StudentApplication.new
    @courses = Course.order(title: :asc)
  end

  def edit
    @courses = Course.order(title: :asc)
  end

  def create
    @student_application = StudentApplication.new(student_application_params)
    @student_application.user = current_user

    respond_to do |format|
      if @student_application.save
        format.html { redirect_to @student_application, notice: "Studen application was successfully created." }
        format.json { render :show, status: :created, location: @student_application }
      else
        @courses = Course.order(title: :asc)
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student_application.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      status = student_application_params[:status]
      
      if status == 'approved'
        @course = Course.find(@student_application.course_id)
        @user = @student_application.user
        @section = Section.find(params[:section_id])

        if @section.required_graders <= 0
          flash[:error] = "This section does not need any more graders!"
          redirect_to action: :show
          return
        end

        unless @section.blank?
          @student_application.user.sections << @section
          @section.required_graders -= 1
          @section.save!
        else
          flash[:error] = "Please select a valid section!"
          redirect_to action: :show
          return
        end
      elsif status == 'denied'
        @student_application.user.sections.each do |section|
          if @course.sections.include?(section)
            @user.sections.delete(section)
            section.required_graders += 1
            @section.save!
          end
        end
      end
      
      if @student_application.update(student_application_params)
        format.html { redirect_to @student_application, notice: "Student application was successfully updated." }
        format.json { render :show, status: :ok, location: @student_application }
      else
        @courses = Course.order(title: :asc)
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student_application.errors, status: :unprocessable_entity }
      end
    end
  end
 
  def destroy
    @student_application.destroy
    respond_to do |format|
      format.html { redirect_to student_applications_url, notice: 'Student application was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_student_application
    @student_application = StudentApplication.find(params[:id])
  end

  def student_application_params
    params.require(:student_application).permit(:status, :contact_info, :preferences_in_grading_assignments, :course_id)
  end

  def authorize_access
    unless current_user.admin? || @student_application.user == current_user
      flash[:alert] = 'You are not authorized to view or edit this application.'
      redirect_to root_url
    end
  end

  def application_not_found
    flash[:alert] = "Application not found."
    redirect_to student_applications_path
  end

  def authorize_admin
    unless current_user.admin?
      flash[:alert] = 'You are not authorized to perform this action.'
      redirect_to root_url
    end
  end
end
