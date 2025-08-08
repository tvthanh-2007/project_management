# app/serializers/token_serializer.rb

class TokenSerializer < ActiveModel::Serializer
  attributes :access_token, :refresh_token

  belongs_to :user, serializer: UserSerializer
end
