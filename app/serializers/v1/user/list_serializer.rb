module V1
  module User
    class ListSerializer < ActiveModel::Serializer
      attributes :id, :name, :email, :role

      def role
        object.role_before_type_cast
      end
    end
  end
end
