# frozen_string_literal: true

require "bootstrap-email"
require "bundler/setup"
require "hanami/api"
require "hanami/middleware/body_parser"

class App < Hanami::API
  use Hanami::Middleware::BodyParser, :json

  post "/" do
    html = params[:html]
    halt(400, "Empty 'html' parameter.") if !html || html.nil? || html.empty?
    headers['Content-Type'] = 'text/html'
    body BootstrapEmail::Compiler.new(html).perform_full_compile
  end
end

run App.new
