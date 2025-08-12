class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :visibility, :user_id

  def visibility
    object.visibility_before_type_cast
  end
end
