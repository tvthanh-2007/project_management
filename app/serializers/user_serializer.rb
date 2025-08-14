class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :role, :email

  def role
    object.role_before_type_cast
  end
end
