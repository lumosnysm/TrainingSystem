class UserSubjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_subject, :load_course, :load_user_subject

  def update
    if params[:commit] == "Start"
      @subject.tasks.each do |task|
        @user_subject.user_tasks.build(task_id: task.id)
      end
      if @user_subject.save
        flash[:success] = t ".create_success"
        redirect_to course_subject_url(@course, @subject)
      else
        flash[:danger] = t ".create_fail"
        redirect_back fallback_location: root_url
      end
    end
  end

  private

  def load_subject
    @subject = Subject.find_by id: params[:subject_id]
    return if @subject
    flash[:danger] = t ".subject_not_exist"
    redirect_back fallback_location: root_url
  end

  def load_course
    @course = Course.find_by id: params[:course_id]
    return if @course
    flash[:danger] = t ".course_not_exist"
    redirect_back fallback_location: root_url
  end

  def load_user_subject
    @user_subject = UserSubject.find_by id: params[:id]
    return if @user_subject
    flash[:danger] = t ".user_subject_not_exist"
    redirect_back fallback_location: root_url
  end
end
