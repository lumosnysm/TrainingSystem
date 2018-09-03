class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_course, only: :show

  def index
    @courses = current_user.courses
  end

  def show
    @subjects = @course.subjects
  end

  private

  def load_course
    @course = Course.find_by id: params[:id]
    return if @course
    flash[:danger] = t ".course_not_exist"
    redirect_back fallback_location: root_url
  end
end
