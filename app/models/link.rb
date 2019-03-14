
require "google/cloud/firestore"

class Link

  attr_accessor :id, :name, :url

  # Return a Google::Cloud::Datastore::Dataset for the configured dataset.
  # The dataset is used to create, read, update, and delete entity objects.
  def initialize options
    @firestore = Google::Cloud::Firestore.new(
      project_id: Rails.application.config.
                        database_configuration[Rails.env]["dataset_id"]
    )
    @link_ref = @firestore.doc "links/#{options[:name]}"
    @name = options[:name]
    @url = options[:url]
    @data = {
      name: @name,
      url: @url
    }
  end

  def self.firestore
    Google::Cloud::Firestore.new(
      project_id: Rails.application.config.
                        database_configuration[Rails.env]["dataset_id"]
    )
  end

  def self.find_by_name name
    link_ref = firestore.doc "links/#{name}"
    snapshot = link_ref.get
    if snapshot.exists?
      link = Link.new snapshot.data
      return link
    else
      false
    end
  end

  def self.create params
    Link.new(params).save
  end

  def self.all
    links_ref = firestore.col "links"
    links = []
    links_ref.get do |link|
      links << Link.new(link.data)
    end
    links
  end

  include ActiveModel::Model

  def save
    if valid?
      @link_ref.set @data
      true
    else
      false
    end
  end
  # [END save]

  # [START validations]
  include ActiveModel::Validations

  validates :name, presence: true
  validates :url, presence: true
  # [END validations]

##################
end
