require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Delianpetrov
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address:              'smtp.zoho.com',
      port:                 465,
      user_name:            Rails.application.credentials[:SMTP_USERNAME],
      password:             Rails.application.credentials[:SMTP_PASSWORD],
      authentication:       :login,
      ssl:                  true,
      tls:                  true,
      enable_starttls_auto: true
    }

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
