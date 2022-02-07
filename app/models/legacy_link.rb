require 'google/cloud/firestore'

# Return a Google::Cloud::Datastore::Dataset for the configured dataset.
# The dataset is used to create, read, update, and delete entity objects.
class LegacyLink
  include ActiveModel::Validations
  include ActiveModel::Model

  attr_accessor :id, :name, :url

  validates :name, presence: true
  validates :url, presence: true

  class << self
    def create(params)
      Link.new(params).save
    end

    def all
      links_ref = firestore.col 'links'
      links = []
      links_ref.get do |link|
        links << Link.new(link.data)
      end
      links
    end

    def find_by_name(name)
      link_ref = firestore.doc "links/#{name}"
      snapshot = link_ref.get
      if snapshot.exists?
        Link.new snapshot.data
      else
        false
      end
    end

    def firestore
      Google::Cloud::Firestore.new(
        credentials: creds
      )
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

  def initialize(options)
    @link_ref = Link.firestore.doc "links/#{options[:name]}"
    @name = options[:name]
    @url = options[:url]
    @data = {
      name: @name,
      url: @url
    }
  end

  def save
    if valid?
      @link_ref.set @data
      true
    else
      false
    end
  end
end
