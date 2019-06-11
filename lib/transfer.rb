class Transfer
  # your code here
  attr_accessor :sender, :receiver, :status, :amount
  @@all = []

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
    self.save
  end

  def save
    @@all << self
  end

  def valid?
    @sender.valid? && @receiver.valid? ? true : false
  end

  def execute_transaction
    if @sender.valid? && @sender.balance >= @amount && @status != "complete"
      @sender.balance = @sender.balance - @amount
      @receiver.balance = @receiver.balance + @amount
      @status = "complete"
      @last_transfer = self
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @last_transfer!= nil && @last_transfer.status == "complete"
      @last_transfer.sender.balance = @last_transfer.sender.balance + @last_transfer.amount
      @last_transfer.receiver.balance = @last_transfer.receiver.balance - @last_transfer.amount
      @last_transfer.status = "reversed"
    end
  end

end
