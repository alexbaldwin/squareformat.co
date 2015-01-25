require 'date'

###
# Instagram
###

Instagram.configure do |config|
  config.client_id = "d58c2933e8d64785b2710e5f6ae0a530"
  config.client_secret = "2f14a46ad961463e9aca89ebf5e6ab66"
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

  rescue
    username
  end

  def avatar(username)
    client = Instagram.client()
    users = client.user_search(username)
    users[0].profile_picture
  rescue
    username
  end

  def full_name(username)
    client = Instagram.client()
    users = client.user_search(username)
    users[0].full_name
  rescue
    username
  end

  # Returns date in form "<h3>22<sup>nd</sup> July</h3>"
  def datify(date)
    daily = Time.parse(date)
    # Use ActiveRecord ordinalize and strip out number.
    ordinal = daily.day.ordinalize.sub(/[0-9]*/, '')
    # http://www.ruby-doc.org/core-2.1.1/Time.html#method-i-strftime
    return daily.strftime("<h3>%-d<sup>#{ordinal}</sup> of %B</h3>")
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
