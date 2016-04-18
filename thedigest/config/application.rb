require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Thedigest
  # Define weighting constants
  TAG_WEIGHT = 4.0
  TITLE_WEIGHT = 3.0
  DESCRIPTION_WEIGHT = 2.0
  SOURCE_WEIGHT = 1.0
  OPENCALAIS_API_KEY = 'MkAInymnCzDkrkRl6mUMTkP81qpcheSk'
  INDICO_API_KEY = '275999bd7f07fbeb2e1c4e75a8ab51f2'
  ALCHEMY_API_KEY = '9529f49b9fdf89ef083966cf07790efbae15a049'
  NYT_API_KEY = '199c76dd8907f94a71cf57d356e332b4:15:72719290'
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
  end
end
