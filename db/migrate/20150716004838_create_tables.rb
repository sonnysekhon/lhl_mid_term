class CreateTables < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string      :name
      t.string      :avatar
      t.string      :email
      t.string      :password
      t.timestamps  null: true
    end
    create_table :cards do |t|
      t.references  :game
      t.string      :name
      t.string      :picture
      t.integer     :attack
      t.integer     :defense
      t.timestamps  null: true
    end
    create_table :games do |t|
      t.references  :user
      t.string      :title
      t.integer     :health
      t.integer     :deck_size
      t.integer     :hand_size
      t.timestamps  null: true
    end
    # copy from here for a new migration
    # create_table :activegames do |t|
    #   t.references  :game
    #   t.integer     :player_one_user_id
    #   t.integer     :player_two_user_id
    #   t.timestamps  null: true
    # end
  end
end
