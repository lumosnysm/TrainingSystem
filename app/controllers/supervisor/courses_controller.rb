class Supervisor::CoursesController < Supervisor::SupervisorBaseController
  include PublicActivity::StoreController
  before_action :load_course, except: %i(index new create)

  def index
    @q = Course.lastest.ransack params[:q]
    @courses = @q.result.page(params[:page]).per Settings.per_page
  end

  def new
    @course = Course.new
  end

  def show
    @subjects = @course.subjects
    @trainees_in_course = @course.users.trainee.
      page(params[:trainees_in]).per Settings.per_page_5
    @trainees_not_in_course = User.trainee.not_in_course(@course).
      page(params[:trainees_not_in]).per Settings.per_page_5
    @supervisors_in_course = @course.users.supervisor.
      page(params[:supervisors_in]).per Settings.per_page_5
    @supervisors_not_in_course = User.supervisor.not_in_course(@course).
      page(params[:supervisors_not_in]).per Settings.per_page_5
    @member = Member.new
    @activities = PublicActivity::Activity.all.order(created_at: :desc).
      page(params[:page]).per Settings.per_page_50
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
    @course.create_activity :update, owner: current_user
    @course.update_attributes course_params
    if @course.save
      flash[:success] = t ".update_success"
    else
      flash[:danger] = t ".update_fail"
    end
    redirect_to supervisor_courses_url
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
    p = params.require(:course).permit :name, :description,
      :start_date, :end_date, :status, subjects_attributes:
      [:id, :name, :description, :detail, :status, :start_date, :end_date, :_destroy,
      tasks_attributes: [:id, :detail, :_destroy]]
    p[:status] = params[:course][:status].to_i
    pp = params[:course][:subjects_attributes]
    if pp
      pp.each do |k, v|
        p[:subjects_attributes][k][:status] = pp[k][:status].to_i
      end
    end
    p
  end

  def load_course
    begin
      @course = Course.find params[:id]
    rescue
      flash[:danger] = t ".course_not_found"
      redirect_back fallback_location: root_url
    end
  end
end
