# config/initializers/omniauth.rb
OmniAuth.config.logger = Rails.logger
OmniAuth.config.allowed_request_methods = [:post, :get]
OmniAuth.config.silence_get_warning = true

OmniAuth.config.before_callback_phase do |env|
  Rails.logger.debug "OmniAuth callback environment: #{env.inspect}"
end
