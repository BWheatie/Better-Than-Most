page "CNAME", layout: false

activate :automatic_image_sizes
activate :blog do |blog|
  blog.sources = "blog/{year}-{month}-{day}-{title}.html"
  blog.layout = "blog"
  blog.taglink = "tags/{tag}.html"
  blog.tag_template = "tag.html"

end
activate :directory_indexes

configure :development do
  activate :livereload
end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'
configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
  activate :relative_assets
end

helpers do
  def active_link_to name, url
    path = request.path
    current = false

    current = url + "/index.html" == path

    if path == 'index.html' and url =="/"
      current = true
    end

    class_name = current ? ' class="active"' : ''

    "<li#{class_name}><a href=\"#{url}\">#{name}</a></li>"
  end
end
activate :deploy do |deploy|
  deploy.method = :git
  deploy.build_before = true
end
