module Supervisor
  class UsersController < SupervisorBaseController
    def index
      @q = User.ransack params[:q]
      @users = @q.result.page(params[:page]).per Settings.per_page
    end
  end
end
