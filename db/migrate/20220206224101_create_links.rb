# frozen_string_literal: true

# creates the link table that is used to redirect to external links
class CreateLinks < ActiveRecord::Migration[5.2]
  def up
    create_table :links do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :url, null: false
      t.boolean :notion, default: false, null: false
    end

    LegacyLink.all.each do |link|
      Link.create(url: link.url, name: link.name)
    end
  end

  def down
    drop_table :links
  end
end
