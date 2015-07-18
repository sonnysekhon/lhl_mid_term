class AddAtttackAndHealthToActiveCards < ActiveRecord::Migration
  def change
    add_column :active_cards, :attack, :integer
    add_column :active_cards, :health, :integer
  end
end
