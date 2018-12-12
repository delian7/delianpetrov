
require "google/cloud/datastore"

class Link

  attr_accessor :id, :name, :url

  # Return a Google::Cloud::Datastore::Dataset for the configured dataset.
  # The dataset is used to create, read, update, and delete entity objects.
  def self.dataset
    @dataset ||= Google::Cloud::Datastore.new(
      project_id: Rails.application.config.
                        database_configuration[Rails.env]["dataset_id"]
    )
  end

  # [START query]
  # Query Link entities from Cloud Datastore.
  #
  # returns an array of Link query results and a cursor
  # that can be used to query for additional results.
  def self.query options = {}
    query = Google::Cloud::Datastore::Query.new
    query.kind "Link"
    query.where "name", "=", options[:name] if options[:name].present?
    query.limit options[:limit]   if options[:limit]
    query.cursor options[:cursor] if options[:cursor]

    results = dataset.run query
    links   = results.map {|entity| Link.from_entity entity }

    return links
  end
  # [END query]

  # [START from_entity]
  def self.from_entity entity
    link = Link.new
    link.id = entity.key.id
    entity.properties.to_hash.each do |name, value|
      link.send "#{name}=", value if link.respond_to? "#{name}="
    end
    link
  end
  # [END from_entity]

  # [START find]
  # Lookup Book by ID.  Returns Book or nil.
  def self.find id
    query    = Google::Cloud::Datastore::Key.new "Link", id.to_i
    entities = dataset.lookup query

    from_entity entities.first if entities.any?
  end

  def self.all
    Link.query
  end

  def self.find_by_name name
    Link.query(name: name).try(:first)
  end
  # [END find]

  # Add Active Model support.
  # Provides constructor that takes a Hash of attribute values.
  include ActiveModel::Model

  def self.create params
    Link.new(params).save
  end

  # [START save]
  # Save the book to Datastore.
  # @return true if valid and saved successfully, otherwise false.
  def save
    if valid?
      entity = to_entity
      Link.dataset.save entity
      self.id = entity.key.id
      true
    else
      false
    end
  end
  # [END save]

  # [START to_entity]
  # ...
  def to_entity
    entity                 = Google::Cloud::Datastore::Entity.new
    entity.key             = Google::Cloud::Datastore::Key.new "Link", id
    entity["name"]         = name
    entity["url"]          = url       if url
    entity
  end
  # [END to_entity]

  # [START validations]
  # Add Active Model validation support to Book class.
  include ActiveModel::Validations

  validates :name, presence: true
  validates :url, presence: true
  # [END validations]

  # [START update]
  # Set attribute values from provided Hash and save to Datastore.
  def update attributes
    attributes.each do |name, value|
      send "#{name}=", value if respond_to? "#{name}="
    end
    save
  end
  # [END update]

  # [START destroy]
  def destroy
    Book.dataset.delete Google::Cloud::Datastore::Key.new "Link", id
  end
  # [END destroy]

##################

  def persisted?
    id.present?
  end
end
