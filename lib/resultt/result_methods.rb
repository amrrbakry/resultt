module ResultMethods
  def map
    return self if self.class == Resultt::Error

    Resultt::Success.new yield value
  rescue StandardError => e
    Resultt::Error.new(e)
  end

  def map_error
    return self if self.class == Resultt::Success

    Resultt::Error.new yield error
  rescue StandardError => e
    Resultt::Error.new(e)
  end
end
