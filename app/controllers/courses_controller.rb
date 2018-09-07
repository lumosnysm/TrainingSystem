class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_course, only: %i(show update)
  before_action :check_start, only: :show

  def index
    @courses = current_user.courses
  end

  def show
    @subjects = @course.subjects
  end

  def update
    if params[:commit]
      @course.subjects.each do |subject|
        @course.user_subjects.build(subject_id: subject.id, user_id: current_user.id)
      end
      if @course.save
        flash[:success] = t ".create_success"
        redirect_to @course
      else
        flash[:danger] = t ".create_fail"
        redirect_back fallback_location: root_url
      end
    end
  end

  private

  def load_course
    @course = Course.find_by id: params[:id]
    return if @course
    flash[:danger] = t ".course_not_exist"
    redirect_back fallback_location: root_url
  end

  def check_start
    return if current_user.courses_started.include? @course
    flash[:danger] = t ".course_started"
    redirect_back fallback_location: root_url
  end
end
