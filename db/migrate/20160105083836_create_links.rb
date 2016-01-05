class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :full_url
      t.string :nickname

      t.timestamps null: false
    end
  end
end
