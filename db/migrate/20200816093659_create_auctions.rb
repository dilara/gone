# frozen_string_literal: true

class CreateAuctions < ActiveRecord::Migration[6.0]
  def change
    create_table :auctions do |t|
      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.integer :status, null: false, default: 0
      t.string :name, null: false, limit: 255
      t.text :description
      t.decimal :base_price, null: false, precision: 10, scale: 2
      t.datetime :starts_at, null: false
      t.datetime :expires_at, null: false

      t.timestamps
    end
  end
end
