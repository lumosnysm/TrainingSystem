class UserSubjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_subject, :load_course, :load_user_subject
  after_action :check_subject_complete

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
    elsif params[:commit] == "Save"
      if @user_subject.update_attributes user_subject_params
        flash[:success] = t ".update_success"
      else
        flash[:danger] = t ".update_fail"
      end
      redirect_back fallback_location: root_url
    end
  end

  private

  def load_subject
    begin
      @subject = Subject.find params[:subject_id]
    rescue
      flash[:danger] = t ".subject_not_exist"
      redirect_back fallback_location: root_url
    end
  end

  def load_course
    begin
      @course = Course.find params[:course_id]
    rescue
      flash[:danger] = t ".course_not_exist"
      redirect_back fallback_location: root_url
    end
  end

  def load_user_subject
    @user_subject = UserSubject.find_by id: params[:id]
    return if @user_subject
    flash[:danger] = t ".user_subject_not_exist"
    redirect_back fallback_location: root_url
  end

  def user_subject_params
    params.require(:user_subject).permit :status, user_tasks_attributes: [:id, :status]
  end

  def check_subject_complete
    return unless @user_subject.user_tasks.find_by_status(true).count == @subject.tasks.count
    @user_subject.update_attributes status: true
  end
end
