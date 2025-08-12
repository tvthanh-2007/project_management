module Api
  module V1
    class UsersController < ApplicationController
      include AuthorizeRequest

      def show
        res(current_user)
      end

      def index
        raise ApiErrors::ForbiddenError if current_user.member?

        res(User.member, as: :list)
      end
    end
  end
end
