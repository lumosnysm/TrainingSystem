module ApplicationHelper
  def link_to_add_fields name, f, association
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render association.to_s.singularize + "_field", f: builder
    end
    link_to name, "#", class: "add_fields btn btn-primary btn-sm h-25", data: {id: id, fields: fields.gsub("\n", "")}
  end

  def find_member user, course
    member = Member.find_by user_id: user.id, course_id: course.id
    if member.nil?
      flash[:danger] = member.id
    end
    return member
  end
end
