###
# Instagram
###

Instagram.configure do |config|
  config.client_id = "4b696399c87d46a1a5638051aba4d589"
  config.client_secret = "7804bd73bd4a4057933e54227b58c34b"
end

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

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

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
# activate :livereload

# Methods defined in the helpers block are available in templates
helpers do
  def recent_media(username)
    client = Instagram.client()
    users = Instagram.user_search(username)
    user_id = users[0].id
    html = ''
    for photo in client.user_recent_media(user_id, count: 3)
      html << "<div class='table-cell'><img src='#{photo.images.standard_resolution.url}' class='fit opacity-25'></div>"
    end
    html
  end

  def avatar(username)
    client = Instagram.client()
    users = Instagram.user_search(username)
    users[0].profile_picture
  end

  def full_name(username)
    client = Instagram.client()
    users = Instagram.user_search(username)
    users[0].full_name
  end
end

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end

activate :deploy do |deploy|
  deploy.build_before = true
  deploy.method = :git
end
