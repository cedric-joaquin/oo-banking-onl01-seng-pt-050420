class Transfer
  attr_accessor :status
  attr_reader :sender, :receiver, :amount 
  
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if sender.balance >= (@amount) && @status == "pending" && sender.valid? && receiver.valid?
      sender.deposit(-(@amount))
      receiver.deposit(@amount)
      self.status = "complete"
    else 
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @status == "complete"
      sender.deposit(@amount)
      receiver.deposit(-@amount)
      @status = "reversed"
    end
  end

end
