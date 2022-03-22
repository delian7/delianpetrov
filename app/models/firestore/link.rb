require 'google/cloud/firestore'

module Firestore
  # Return a Google::Cloud::Datastore::Dataset for the configured dataset.
  # The dataset is used to create, read, update, and delete entity objects.
  class Link
    include ActiveModel::Validations
    include ActiveModel::Model

    FIRESTORE_CLIENT = Firestore::Client.call

    attr_accessor :name, :url

    validates :name, presence: true
    validates :url, presence: true

    class << self
      def create(params)
        new(params).save
      end

      def all
        links_ref = FIRESTORE_CLIENT.col 'links'
        links = []
        links_ref.get do |link|
          data = link.data
          links << new(name: data[:name], url: data[:url])
        end
        links
      end

      def find_by_name(name)
        link_ref = FIRESTORE_CLIENT.doc "links/#{name}"
        snapshot = link_ref.get
        return nil unless snapshot.exists?

        new(name: snapshot.data[:name], url: snapshot.data[:url])
      end
    end

    def initialize(name:, url:)
      @name = name
      @url = url
    end

    def save
      return false unless valid?

      link_ref = FIRESTORE_CLIENT.doc("links/#{name}")
      link_ref.set(
        {
          name: name,
          url: url
        }
      )

      true
    end
  end
end
