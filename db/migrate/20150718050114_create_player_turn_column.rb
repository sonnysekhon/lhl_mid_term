class CreatePlayerTurnColumn < ActiveRecord::Migration
  def change
    add_column :active_games, :turn, :integer
  end
end
