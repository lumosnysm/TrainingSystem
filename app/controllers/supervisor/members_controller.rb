class Supervisor::MembersController < Supervisor::SupervisorBaseController
  include PublicActivity::StoreController
  before_action :load_member, only: :destroy

  def create
    old = Member.only_deleted.find_by course_id: params[:member][:course_id],
      user_id: params[:member][:user_id]
    if old
      old.restore
    else
      @member = Member.create member_params
      if @member.save
        flash[:success] = t ".create_success"
      else
        flash[:danger] = t ".create_fail"
      end
    end
    redirect_back fallback_location: root_url
  end

  def destroy
    if @member.destroy
      flash[:success] = t ".deleted_success"
    else
      flash[:danger] = t ".deleted_fail"
    end
    redirect_back fallback_location: root_url
  end

  private

  def member_params
    params.require(:member).permit :user_id, :course_id
  end

  def load_member
    @member = Member.find_by id: params[:id]
    return if @member
    flash[:danger] = t ".not_found"
    redirect_back fallback_location: root_url
  end
end
