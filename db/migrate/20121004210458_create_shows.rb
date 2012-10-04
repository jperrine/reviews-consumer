class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :name
      t.text :description
      t.string :widget_key

      t.timestamps
    end
  end
end
