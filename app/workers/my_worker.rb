class MyWorker
  include Sidekiq::Worker

  def perform email, course_name, assign
    if assign
      UserMailer.assign_trainee(email, course_name).deliver_now
    else
      UserMailer.remove_trainee(email, course_name).deliver_now
    end
  end
end
