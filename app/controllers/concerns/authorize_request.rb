module AuthorizeRequest
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request!
  end

  def current_user
    @current_user
  end

  def authenticate_request!
    header = request.headers["Authorization"]
    header = header.split(" ").last if header
    decoded = JsonWebToken.decode(header)

    if decoded && (user = User.find_by(id: decoded[:user_id]))
      @current_user = user
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end
end
