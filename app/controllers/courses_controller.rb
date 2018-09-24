class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_course, only: %i(show update)
  before_action :check_start, :check_close, only: :show

  def index
    @q = current_user.courses.not_closed.sort_by_date.ransack params[:q]
    @courses = @q.result.page(params[:page]).per Settings.per_page
    @total = current_user.courses.not_closed.count
    @locked = current_user.count_courses_locked
    @inprogress = current_user.count_courses_inprogress
    @completed = current_user.count_courses_completed
  end

  def show
    @q = @course.subjects.sort_by_date.ransack params[:q]
    @subjects = @q.result.page(params[:page]).per Settings.per_page
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
    @course = Course.find_by slug: params[:id]
    return if @course
    flash[:danger] = t ".course_not_exist"
    redirect_back fallback_location: root_url
  end

  def check_start
    return if current_user.courses_started.include? @course
    flash[:danger] = t ".course_not_started"
    redirect_back fallback_location: root_url
  end

  def check_close
    return unless @course.closed?
    flash[:danger] = t ".course_closed"
    redirect_back fallback_location: root_url
  end
end
