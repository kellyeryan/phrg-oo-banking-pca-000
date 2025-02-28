class Transfer

  attr_reader :sender, :receiver, :status, :amount

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    return if @status == "complete"

    if !valid? || sender.balance < amount
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    else
      @status = "complete"
      sender.balance -= amount
      receiver.balance += amount
    end
  end

  def reverse_transfer
    if @status == "complete"
      sender.balance += amount
      receiver.balance -= amount
      @status = "reversed"
    end
  end
end
