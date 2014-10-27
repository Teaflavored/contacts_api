class AddFavoritedToContactShare < ActiveRecord::Migration
  def change
    add_column :contact_shares, :favorited, :boolean, default: false
  end
end
