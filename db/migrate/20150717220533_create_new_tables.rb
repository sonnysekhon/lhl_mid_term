class CreateNewTables < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.references  :active_game
      t.integer     :player_health
      t.timestamps  null: true
    end
    create_table :active_cards do |t|
      t.references  :player
      t.references  :card
      t.string      :status
      t.timestamps  null: true
    end
    create_table :active_games do |t|
      t.references  :game
      t.integer     :player1_id
      t.integer     :player2_id
      t.timestamps  null: true
    end
  end
end
