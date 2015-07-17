class ActiveCard < ActiveRecord::Base
  belongs_to :player
  belongs_to :card
end