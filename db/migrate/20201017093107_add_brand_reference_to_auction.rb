class AddBrandReferenceToAuction < ActiveRecord::Migration[6.0]
  def change
    add_reference :auctions, :brand, index: true
  end
end
