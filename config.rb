activate :directory_indexes

set :relative_links, true

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end
data.pages.each do |page|
  if page['id'].to_s == '3'
    proxy "/#{(page.name).parameterize}.html", "/project_template.html",
    :locals => { :name => page.name, :id => page.id },
    :ignore => true
  else
    proxy "/#{(page.name).parameterize}.html", "/page_template.html",
    :locals => { :id => page.id },
    :ignore => true
  end
end

###
# Helpers
###
helpers do
  def nav_active(page)
    this_page = page_classes.gsub(/\s.+/, '')
    this_page == page ? {:class => "active"} : {}
  end

  def render_page_partial(s)
    case s.to_s
    when '2'
      partial "pages/our-company"
    when '4'
      partial "pages/our-services"
    when '5'
      partial "pages/contact-form"
    else
      partial "pages/our-company"
    end
  end
end

# Use LiveReload
activate :livereload

# Compass configuration
set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

set :fonts_dir, 'fonts'

set :haml, { :ugly => true, :format => :html5 }


# Build-specific configuration
configure :build do
  ignore 'images/*.psd'
  ignore 'stylesheets/lib/*'
  ignore 'stylesheets/vendor/*'
  ignore 'javascripts/lib/*'
  ignore 'javascripts/vendor/*'

  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  activate :cache_buster

  # Use relative URLs
  # activate :relative_assets

  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  # activate :smusher

  # Or use a different image path
  # set :http_path, "/Content/images/"
end
