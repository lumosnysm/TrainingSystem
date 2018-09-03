module SubjectsHelper
  def find_user_subject user, subject
    user_subject = UserSubject.find_by user_id: user.id, subject_id: subject.id
    return user_subject if user_subject
    flash[:danger] = t ".user_subject_not_found"
  end
end
