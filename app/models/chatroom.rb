class Chatroom < ApplicationRecord
  belongs_to :user
  belongs_to :tutor
  belongs_to :course
  has_many :messages, dependent: :destroy
  has_one :notification, dependent: :destroy

  before_destroy :chat_charge

  protected

  def chat_charge

    rate = 0.694444445

    user = User.find(self.user_id)
    tutor = Tutor.find(self.tutor_id)

    amount = ((DateTime.now.utc.to_i - self.start.to_datetime.utc.to_i) * rate).to_i

    user.pay(amount,tutor.stripe_id)

  end
end
