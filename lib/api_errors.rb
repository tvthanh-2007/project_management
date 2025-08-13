module ApiErrors
  class UnauthorizedError < StandardError; end
  class ForbiddenError < StandardError; end
  class InvitationError < StandardError; end
end
