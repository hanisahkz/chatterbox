class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy

  #technically, Conversation belongs to User either through sender or recipient
  belongs_to :sender, foreign_key: :sender_id, class_name: User #these 2 are custom attributes
  belongs_to :recipient, foreign_key: :recipient_id, class_name: User #these 2 are custom attributes 
  
  validates :sender_id, uniqueness: { scope: :recipient_id } #this prevents duplication of record. works OK even without validation

  #this is the logic needed in order to return the conversation betweeen 2 users
  scope :between, -> (sender_id, recipient_id) do #this will filter the conversation into between the 2
    where(sender_id: sender_id, recipient_id: recipient_id).or(
      where(sender_id: recipient_id, recipient_id: sender_id)
    )
  end

  #this part has a lot of techniques that i've never seen before
  def self.get(sender_id, recipient_id)
    conversation = between(sender_id, recipient_id).first #instance method. there can be many conversation. So, get the first one
    return conversation if conversation.present?  
    create(sender_id: sender_id, recipient_id: recipient_id)
  end

  # this definition is for opposing identity. If the user is a recipient, then the opposed user should be a sender
  def opposed_user(user)
    user == recipient ? sender : recipient
  end
  
end
