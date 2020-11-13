class Transfer
  attr_accessor :status
  attr_reader :sender, :receiver

  def initialize(sender, receiver, tr_amount = 50)
    @sender = sender
    @receiver = receiver
    @tr_amount = tr_amount
    @status = "pending"
  end

  def amount
    @tr_amount
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
      if sender.balance > amount && self.status == "pending" && valid?
        sender.balance -= amount
        receiver.balance += amount
        self.status = "complete"
      else
        reject_transfer
      end
  end

  def reject_transfer
    self.status = "rejected"
    "Transaction rejected. Please check your account balance."
  end

  def reverse_transfer
    if receiver.balance > amount && self.status == "complete" && valid?
      sender.balance += amount
      receiver.balance -= amount
      self.status = "reversed"
    else
      reject_transfer
    end
  end

end
