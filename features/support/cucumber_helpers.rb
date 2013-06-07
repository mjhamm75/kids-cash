module CucumberHelpers
  def addStrings(balance, amount)
    balanceFloat = stringToFloat(balance)
    amountFloat = stringToFloat(amount)
    return number_with_precision(balanceFloat.to_f + amountFloat.to_f, :precision => 2)
  end

  def stringToFloat (amount)
    return number_with_precision(amount.to_f, :precision => 2)
  end
end

World(CucumberHelpers)