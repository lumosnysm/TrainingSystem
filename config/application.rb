require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module TrainingSystem
  class Application < Rails::Application
    config.load_defaults 5.2
    config.i18n.default_locale = :en
    config.autoload_paths += %W(#{config.root}/app/workers)
  end
end
