require 'net/http'
class HttpPostJob < ApplicationJob
  def perform(uri, params)
    Net::HTTP.post_form(URI.parse(uri), params)
  end
end
