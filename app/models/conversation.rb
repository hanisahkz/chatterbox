class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy

  belongs_to :sender, foreign_key: :sender_id, class_name: User #these are responsible in allowing user to have multiple identities
  belongs_to :recipient, foreign_key: :recipient_id, class_name: User #these are responsible in allowing user to have multiple identities 
  validates :sender_id, uniqueness: { scope: :recipient_id }

  def opposed_user(user)
    user == recipient ? sender : recipient
  end
  
end
