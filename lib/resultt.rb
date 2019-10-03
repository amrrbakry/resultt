require "resultt/version"
require "resultt/result_methods"

module Resultt
  def Result
    success = Success.new yield
    raise 'Not found' if success.value.nil?

    success
  rescue StandardError => e
    Error.new(e)
  end

  def Success(value)
    Success.new(value)
  end

  def Error(error)
    Error.new(error)
  end

  class Success
    include ResultMethods

    attr_reader :value

    def initialize(value)
      @value = value
    end

    def ok?
      true
    end
    alias success? ok?

    def error?
      false
    end
  end

  class Error
    include ResultMethods

    attr_reader :error

    def initialize(error)
      @error = error
    end

    def error?
      true
    end

    def ok?
      false
    end
    alias success? ok?
  end
end
