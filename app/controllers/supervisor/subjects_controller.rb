module Supervisor
  class SubjectsController < SupervisorBaseController
    before_action :load_subject

    def update
      @subject.update_attributes subject_params
      if @subject.save
        flash[:success] = t ".update_success"
      else
        flash[:danger] = t ".update_fail"
      end
      redirect_back fallback_location: root_url
    end

    private

    def subject_params
      p = params.require(:subject).permit :name, :description,
        :detail, :start_date, :end_date, :status
      p[:status] = params[:subject][:status].to_i
      return p
    end

    def load_subject
      @subject = Subject.find_by id: params[:id]
      return if @subject
      flash[:danger] = t ".subject_not_found"
      redirect_back fallback_location: root_url
    end
  end
end
