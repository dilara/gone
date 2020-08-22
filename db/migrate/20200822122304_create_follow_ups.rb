# frozen_string_literal: true

class CreateFollowUps < ActiveRecord::Migration[6.0]
  def change
    create_table :follow_ups do |t|
      t.references :follower, null: false, foreign_key: { to_table: :users }
      t.references :following, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
