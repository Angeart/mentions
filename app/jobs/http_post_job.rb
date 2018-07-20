require 'net/http'
class HttpPostJob < ApplicationJob
  def perform(uri, params)
    p [params]
    Net::HTTP.post_form(URI.parse(uri), params)
  end
end
