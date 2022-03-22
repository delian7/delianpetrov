require 'singleton'
require 'google/cloud/firestore'

module Firestore
  class Client < ApplicationService
    include Singleton

    def initialize
      @client = Google::Cloud::Firestore.new(
        credentials: creds
      )
    end

    def call
      @client
    end

    private

    def creds
      if ENV['GOOGLE_APPLICATION_CREDENTIALS']
        JSON.parse(ENV['GOOGLE_APPLICATION_CREDENTIALS'])
      else
        ENV['GOOGLE_APPLICATION_CREDENTIAL_FILE']
      end
    end
  end
end
