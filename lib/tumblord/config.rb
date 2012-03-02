require "tumblord/version"

module Tumblord
  module Config

    ADAPTER = :net_http
    ENDPOINT = "http://api.tumblr.com"
    USER_AGENT = "Tumblord Ruby Gem #{Tumblord::VERSION}"

    # An array of valid keys in the options hash when configuring a {Tumblord::Client}
    VALID_OPTIONS_KEYS = [
      :consumer_key,
      :consumer_secret,
      :endpoint,
      :oauth_token,
      :oauth_token_secret,
      :user_agent
    ]

    attr_accessor *VALID_OPTIONS_KEYS

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
      self
    end

    # Create a hash of options and their values
    def options
      options = {}
      VALID_OPTIONS_KEYS.each{|k| options[k] = send(k)}
      options
    end

    # Reset all configuration options to defaults
    def reset
      self.endpoint           = ENDPOINT
      self.user_agent         = USER_AGENT
      self
    end
  end
end