class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.string :file, null: false
      t.jsonb :exif, null: false, default: '{}'

      t.timestamps
    end

    add_index  :photos, :exif, using: :gin
  end
end
