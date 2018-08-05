# frozen_string_literal: true

require "faraday"

class Sportradar
  attr_accessor :current_options

  def initialize(options={}, &block)
    @current_options = options
    self
  end

  def api_call(endpoint)
    Faraday.get(endpoint)
  end
end
