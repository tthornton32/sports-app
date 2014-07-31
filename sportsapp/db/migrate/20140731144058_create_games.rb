class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.float :latitude
      t.float :longitude
      t.string :address
      t.text :description
      t.string :title
      t.datetime :time
      t.string :skill_level

      t.timestamps
    end
  end
end
