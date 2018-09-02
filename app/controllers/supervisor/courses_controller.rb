module Supervisor
  class CoursesController < SupervisorBaseController
    before_action :load_course, only: %i(edit update destroy)

    def index
      @courses = Course.fields.lastest.
        page(params[:page]).per Settings.per_page
    end

    def new
      @course = Course.new
    end

    def edit; end

    def create
      @course = Course.new course_params
      if @course.save
        flash[:success] = t ".create_success"
      else
        flash[:danger] = t ".create_fail"
      end
      redirect_back fallback_location: root_url
    end

    def update
      @course.update_attributes course_params
      if @course.save
        flash[:success] = t ".update_success"
      else
        flash[:danger] = t ".update_fail"
      end
      redirect_back fallback_location: root_url
    end

    def destroy
      if @course.destroy
        flash[:success] = t ".destroy_success"
      else
        flash[:danger] = t ".destroy_fail"
      end
      redirect_back fallback_location: root_url
    end

    private

    def course_params
      params.require(:course).permit :name, :description,
        :start_date, :end_date, :status, subjects_attributes:
        [:id, :name, :description, :detail, :start_date, :end_date, :_destroy,
        tasks_attributes: [:id, :detail, :_destroy]]
    end

    def load_course
      @course = Course.find_by id: params[:id]
      return if @course
      flash[:danger] = t ".course_not_found"
      redirect_back fallback_location: root_url
    end
  end
end
