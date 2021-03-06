require 'google-oauth2-installed/version'
require 'google-oauth2-installed/setup'
require 'google-oauth2-installed/checks'
require 'google-oauth2-installed/access_token'

module GoogleOauth2Installed

  # A centralized place to access all loaded configuration and defaults.
  def self.credentials
    {
      method: 'OAuth2',
      oauth2_client_id: ENV["OAUTH2_CLIENT_ID"],
      oauth2_client_secret: ENV["OAUTH2_CLIENT_SECRET"],
      oauth2_token: oauth2_token,
      oauth2_scope: ENV['OAUTH2_SCOPE'],
      oauth2_redirect_uri: 'urn:ietf:wg:oauth:2.0:oob',
      oauth2_urls: {
        authorize_url: 'https://accounts.google.com/o/oauth2/auth',
        token_url: 'https://accounts.google.com/o/oauth2/token',
      },
    }
  end

  def self.access_token
    AccessToken.new(credentials).access_token
  end

  # To be used interactively
  def self.get_access_token
    Setup.new(credentials).get_access_token
  end

  private

  def self.oauth2_token
    if ENV["OAUTH2_ACCESS_TOKEN"]
      {
        access_token: ENV["OAUTH2_ACCESS_TOKEN"],
        refresh_token: ENV["OAUTH2_REFRESH_TOKEN"],
        expires_at: ENV["OAUTH2_EXPIRES_AT"].to_i,
      }
    end
  end

end


require 'google-oauth2-installed/railtie' if defined?(Rails::Railtie)
