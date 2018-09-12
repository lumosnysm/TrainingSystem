module CoursesHelper
  def course_start course
    current_user.courses_started.include? course
  end

  def course_done course
    current_user.user_subjects.where(course_id: course.id).find_by_status(true).count ==
      course.subjects.count
  end

  def count_user_subject course
    current_user.user_subjects.find_by_course(course).count
  end
end
