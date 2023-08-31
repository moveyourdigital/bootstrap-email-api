# frozen_string_literal: true

require "bootstrap-email"
require "bundler/setup"
require "hanami/api"
require "hanami/middleware/body_parser"

class Result
  attr_reader :compiler, :error, :status

  def initialize(compiler: nil, error: nil, status: nil)
    @compiler = compiler
    @error = error
    @status = status
  end

  def success?
    !@compiler.nil?
  end

  def failure?
    !success?
  end
end

class App < Hanami::API
  use Hanami::Middleware::BodyParser, :json

  render = -> (params) do
    html = params[:html]

    return Result.new(
      error: "Empty 'html' parameter.", status: 422
    ) if !html || html.nil? || html.empty?

    begin
      Result.new(
        compiler: BootstrapEmail::Compiler.new(html, options: {
          sass_email_string: params[:scss]&.concat("\n//= @import bootstrap-email;")
        })
      )
    rescue => e
      Result.new(
        error: "Compilation Error: #{e.message}", status: 500
      )
    end
  end

  post "/" do
    redirect "/html", 307
  end

  post "/html" do
    headers['Content-Type'] = 'text/html'

    result = render.call(params)
    halt result.status, result.error if result.failure?
    body result.compiler.perform_html_compile
  end

  post "/plaintext" do
    headers['Content-Type'] = 'text/plain'

    result = render.call(params)
    halt result.status, result.error if result.failure?
    body result.compiler.perform_text_compile
  end

  post "/multipart" do
    result = render.call(params)
    halt result.status, result.error if result.failure?
    json result.compiler.perform_multipart_compile
  end
end

run App.new
