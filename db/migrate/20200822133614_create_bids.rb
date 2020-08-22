class CreateBids < ActiveRecord::Migration[6.0]
  def change
    create_table :bids do |t|
      t.references :bidder, null: false, foreign_key: { to_table: :users }
      t.references :auction, null: false
      t.decimal :offer, null: false, precision: 10, scale: 2
      t.datetime :made_at, null: false

      t.timestamps
    end
  end
end
