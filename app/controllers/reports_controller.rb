class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_report, :correct_user, except: %i(new create index)

  def index
    @q = current_user.reports.sort_by_date.ransack params[:q]
    @reports = @q.result.page(params[:page]).per params[:limit]
    @report = Report.new
  end

  def create
    @report = current_user.reports.build report_params
    if @report.save
      flash[:success] = t ".create_success"
      redirect_to reports_url
    else
      flash[:danger] = t ".create_fail"
      render :new
    end
  end

  def edit; end

  def update
    if @report.update_attributes report_params
      flash[:success] = t ".update_success"
      redirect_to reports_url
    else
      flash[:danger] = t ".update_fail"
      render :edit
    end
  end

  def destroy
    if @report.destroy
      flash[:success] = t ".delete_success"
    else
      flash[:danger] = t ".delete_fail"
    end
    redirect_to reports_url
  end


  private

  def report_params
    params.require(:report).permit :title, :content
  end

  def load_report
    @report = current_user.reports.find_by id: params[:id]
    return if  @report
    flash[:danger] = t ".report_not_exist"
    redirect_to root_url
  end

  def correct_user
    @user = User.find_by id: @report.user_id
    return if current_user == @user
    flash[:danger] = t ".not_correct_user"
    redirect_to root_url
  end
end
