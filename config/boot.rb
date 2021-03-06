# Defines our messages
RACK_ENV = ENV['RACK_ENV'] ||= 'development' unless defined?(RACK_ENV)
ENV['API_KEY'] = 'zaraza' if ENV['API_KEY'].nil?
PADRINO_ROOT = File.expand_path('..', __dir__) unless defined?(PADRINO_ROOT)

# Load our dependencies
require 'bundler/setup'
Bundler.require(:default, RACK_ENV)

#
# # Enable devel logging
#
# Padrino::Logger::Config[:development][:log_level]  = :devel
# Padrino::Logger::Config[:development][:log_static] = true
#
# # Configure your I18n
#
# I18n.default_locale = :en
#
# # Configure your HTML5 data helpers
#
# Padrino::Helpers::TagHelpers::DATA_ATTRIBUTES.push(:dialog)
# text_field :foo, :dialog => true
# Generates: <input type="text" data-dialog="true" name="foo" />
#
# # Add helpers to mailer
#
# Mail::Message.class_eval do
#   include Padrino::Helpers::NumberHelpers
#   include Padrino::Helpers::TranslationHelpers
# end

#
# Add your before (RE)load hooks here
#
Padrino.before_load do
  Padrino.dependency_paths << Padrino.root('app/exceptions/**/*.rb')
  Padrino.dependency_paths << Padrino.root('app/repositories/**/*.rb')
end

#
# Add your after (RE)load hooks here
#
Padrino.after_load do
end

Padrino.load!
