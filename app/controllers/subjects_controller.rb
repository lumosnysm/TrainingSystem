class SubjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_subject, :check_start

  def show
    @tasks = @subject.tasks
  end

  private

  def load_subject
    @subject = Subject.find_by id: params[:id]
    return if @subject
    flash[:danger] = t ".subject_not_exist"
    redirect_back fallback_location: root_url
  end


  def check_start
    user_subject = current_user.user_subjects.find_by(subject_id: params[:id])
    if user_subject.nil?
      flash[:danger] = t ".user_subject_not_exist"
    else
      return if user_subject.user_tasks.count > 0
      flash[:danger] = t ".subject_not_started"
    end
    redirect_back fallback_location: root_url
  end
end
