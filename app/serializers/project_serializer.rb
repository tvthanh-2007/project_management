class ProjectSerializer < ActiveModel::Serializer
  attributes :name, :description, :visibility

  def visibility
    object.visibility_before_type_cast
  end
end
