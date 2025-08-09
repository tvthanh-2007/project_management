module ApiErrors
  class UnauthorizedError < StandardError; end
  class ForbiddenError < StandardError; end
end
