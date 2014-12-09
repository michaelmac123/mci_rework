activate :directory_indexes

# set :relative_links, true

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

# Standard Page route
data.pages.each do |page|
  proxy "/#{(page.name).parameterize}.html", "/page_template.html",
  :locals => {  :name => page.name, :id => page.id, :page_slogan => page.page_slogan },
  :ignore => true
end

# Projects Page route
data.projects.each do |project|
  proxy "our-projects/#{(project.name).parameterize}.html", "/project_template.html",
  :locals => {  :name => project.name, :id => project.id, :project_slogan => project.page_slogan },
  :ignore => true
end

page "/press-releases/*", :layout => false

page "/thank-you.html"

###
# Helpers
###
helpers do
  def nav_active(page)
    if current_page.url.match(/^[\/]$/) == "/" || current_page.url == "/home"
      {:class => "active"}
    else
      current_page.url == "#{page}" ? {:class => "active"} : {}
    end
  end

  def render_page_partial(s, ps=nil)
    case s.to_s
    when '2'
      partial "pages/our-company", :locals => {:id => s, :page_slogan => ps }
    when '3'
      partial "pages/our-projects", :locals => {:id => s, :page_slogan => ps }
    when '4'
      partial "pages/our-services", :locals => {:id => s, :page_slogan => ps }
    when '5'
      partial "pages/our-news", :locals => {:id => s, :page_slogan => ps }
    when '6'
      partial "pages/contact-form", :locals => {:id => s, :page_slogan => ps }
    else
      partial "pages/our-company", :locals => {:id => s, :page_slogan => ps }
    end
  end

  def inline_svg(path, opts={})
    file = File.open("source/images/#{path}.svg", "r")
    klass = opts[:class] ||= ""
    klass << " #{path}"
    svg = file.read
    svg = content_tag :span, svg, class: klass, title: opts[:title] || ""
  end

  def files_in(dir, options = {})
    if options[:extensions]
      extensions = [options[:extensions]].flatten.compact.uniq
      options[:glob_pattern] = "**/*.{#{extensions.join(',')}}"
    end

    options[:glob_pattern] ||= "**/*"

    full_dir = File.join(source_dir, dir)
    file_pattern = File.join(full_dir, options[:glob_pattern])
    Dir.glob(file_pattern)
  end

  def image_check(img)
    if File.file?("#{root}/source/images/client-logos/logo-#{img.parameterize}.png")
      content_tag :div, class: "call-out-circle hidden-xs" do
        image_tag "client-logos/logo-#{img.parameterize}.png", alt: "Mitchell Contractor | #{img}", class: 'call-out-client-logo'
      end
    else
      content_tag :span
    end
  end

  def image_paths_in(dir)
    image_paths = files_in(dir, extensions: %w{ jpg gif jpeg png })

    image_paths.map do |path|
      path.split(source_dir).last
    end
  end

  def fixed_array(size)
     Array.new(size)
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
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :cache_buster

  # Use relative URLs
  activate :relative_assets

  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  # activate :smusher

  # Or use a different image path
  # set :http_path, "/Content/images/"
end
