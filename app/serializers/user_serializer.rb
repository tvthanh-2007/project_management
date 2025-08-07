class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :role

  def role
    object.role_before_type_cast
  end
end
