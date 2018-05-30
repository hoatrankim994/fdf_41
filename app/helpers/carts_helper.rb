module CartsHelper
  def amount unit_price, quantity
    unit_price * quantity
  end

  def total_price order_details
    total = 0
    order_details.each do |item|
      total += amount item.product_price, item.quantity
    end
    total
  end
end
