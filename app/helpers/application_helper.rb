module ApplicationHelper
  def money_br(money)
	if money != nil
	  money = number_to_currency money
	end
  end
end
