class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  # １対多のDM
  validates :content, presence: true, length: { maximum:140 }
end
