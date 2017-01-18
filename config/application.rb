require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Store
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components', 'jquery', 'dist')
    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components', 'jquery-ujs', 'src')
    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components', 'toastr')
    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components', 'bootstrap', 'dist')
    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components', 'leaflet', 'dist')
    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components', 'leaflet-draw', 'dist')
    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components', 'AlertifyJS', 'build')
    config.assets.precompile.push(Proc.new do |path|
      File.extname(path).in? [
        '.png',  '.gif', '.jpg', '.jpeg', '.svg', # Images
        '.eot',  '.otf', '.svc', '.woff', '.ttf', # Fonts
      ]
    end)
  end
end
