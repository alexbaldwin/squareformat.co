###
# Instagram
###

Instagram.configure do |config|
  config.client_id = "4b696399c87d46a1a5638051aba4d589"
  config.client_secret = "7804bd73bd4a4057933e54227b58c34b"
end

# activate :livereload

helpers do
  def recent_media(username)
    client = Instagram.client()
    users = Instagram.user_search(username)
    user_id = users[0].id
    html = ''
    for photo in client.user_recent_media(user_id, count: 3)
      html << "<div class='table-cell'><img src='#{photo.images.standard_resolution.url}' class='fit opacity-25 smooth-sailing'></div>"
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

configure :build do
  activate :minify_html
  activate :minify_css
  # activate :minify_javascript
  activate :asset_hash
  activate :cache_buster
  activate :relative_assets
  activate :gzip
end

activate :deploy do |deploy|
  deploy.build_before = true
  deploy.method = :git
end
