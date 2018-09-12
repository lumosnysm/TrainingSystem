class UserMailer < ApplicationMailer
  def assign_trainee email, course_name
    @course_name = course_name
    mail to: email, subject: t(".subject")
  end

  def remove_trainee email, course_name
    @course_name = course_name
    mail to: email, subject: t(".subject")
  end
end
