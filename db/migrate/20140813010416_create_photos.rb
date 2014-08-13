class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.text :credit
      t.integer :project_id

      t.timestamps
    end
  end
end
