class SubjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_subject, :load_user_subject,
    :load_course, :check_in_course, :check_start

  def show
    @tasks = @subject.tasks
  end

  private

  def load_subject
    begin
      @subject = Subject.find params[:id]
    rescue
      flash[:danger] = t ".subject_not_exist"
      redirect_back fallback_location: root_url
    end
  end

  def check_start
    user_subject = current_user.user_subjects.find_by(subject_id: @subject.id)
    if user_subject.nil?
      flash[:danger] = t ".user_subject_not_exist"
    else
      return if user_subject.user_tasks.count > 0
      flash[:danger] = t ".subject_not_started"
    end
    redirect_back fallback_location: root_url
  end

  def load_user_subject
    @user_subject = UserSubject.find_by user_id: current_user.id, subject_id: @subject.id
    return if @user_subject
    flash[:danger] = t ".user_subject_not_exist"
    redirect_back fallback_location: root_url
  end

  def load_course
    begin
      @course = Course.find params[:course_id]
    rescue
      flash[:danger] = t ".course_not_exist"
      redirect_back fallback_location: root_url
    end
  end

  def check_in_course
    return if current_user.courses.include? @course
    flash[:danger] = t ".not_in_course"
    redirect_to courses_url
  end
end
