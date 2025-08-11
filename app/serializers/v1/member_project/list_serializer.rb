module V1
  module MemberProject
    class ListSerializer < ActiveModel::Serializer
      attributes :id, :role, :name, :email

      def role
        object.role_before_type_cast
      end

      def name
        object.user.name
      end

      def email
        object.user.email
      end
    end
  end
end
