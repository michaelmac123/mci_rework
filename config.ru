require "rubygems"

require "rack"
require "middleman/rack"
require 'rack/contrib/static_cache'
require "rack/contrib/try_static"
require "middleman-smusher"

# Build the static site when the app boots
  # "bundle exec middleman build"

# Add http auth to heroku via puma
# use Rack::Auth::Basic, "Restricted Area" do |username, password|
#   [username, password] == ['kod-tester', 'test-kod']
# end

# require File.expand_path("../rack_try_static", __FILE__)

# Enable proper HEAD responses
# use Rack::Head
use Rack::ResponseHeaders do |headers|
  headers['Content-Type'] = 'text/html; charset=utf-8' if headers['Content-Type'] == 'text/html'
end

use Rack::Deflater

# Cache assets
use Rack::StaticCache,
  urls: [
    "/images",
    "/stylesheets",
    "/javascripts",
    "/fonts"],
  root: "build"

# Attempt to serve static HTML files
use Rack::TryStatic,
    :root => "build",
    :urls => %w[/],
    :try => ['.html', 'index.html', '/index.html']

# Serve a 404 page if all else fails
run lambda { |env|
  [
    404,
    {
      "Content-Type"  => "text/html",
      "Cache-Control" => "public, max-age=60"
    },
    File.open("build/404/index.html", File::RDONLY)
  ]
}