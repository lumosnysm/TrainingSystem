module CoursesHelper
  def course_start course
    current_user.courses_started.include? course
  end
end
