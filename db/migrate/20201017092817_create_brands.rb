class CreateBrands < ActiveRecord::Migration[6.0]
  def change
    create_table :brands do |t|
      t.integer :status, null: false, default: 0
      t.string :name, null: false, limit: 255

      t.timestamps
    end
  end
end
