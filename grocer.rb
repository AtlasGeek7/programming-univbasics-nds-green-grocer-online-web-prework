$idx = -1

def find_item_by_name_in_collection(name,collection)
  i = 0
  while i < collection.length
    if (collection[i][:item] === name.upcase)
      $idx = i
      return collection[i]
    end
    i += 1
  end
  return nil
end

def consolidate_cart(cart)
  arr = []
  i = 0
  j = 0
  while i < cart.length
    if (find_item_by_name_in_collection(cart[i][:item], arr) === nil)
      arr << cart[i]
      arr[j][:count] = 1
      j += 1
    else
      arr[$idx][:count] += 1
    end
    i += 1
  end
  return arr
end

def apply_coupons(cart,coupons)
  arr = cart
  i = 0
  while i < cart.length
    j = 0
    while j < coupons.length
      if (cart[i][:item] === coupons[j][:item] && cart[i][:count] >= coupons[j][:num])
        arr << {:item => "#{cart[i][:item]} W/COUPON", :price => coupons[j][:cost] / coupons[j][:num],:clearance => cart[i][:clearance],:count => (cart[i][:count] - (cart[i][:count] % coupons[j][:num]))}
          arr[i][:count] = cart[i][:count] % coupons[j][:num]
      end
      j += 1
    end
    i += 1  
  end
  return arr
end

def apply_clearance(cart)
  arr = []
  i = 0
  while i < cart.length
    cart[i][:clearance] ? price = (cart[i][:price] - cart[i][:price] * 0.2).round(2) : price = cart[i][:price]
    arr << {:item => cart[i][:item], :price => price,:clearance => cart[i][:clearance],:count => cart[i][:count]} 
    i += 1  
  end
  return arr 
end

def total_price_by_item(item)
  return item[:count] * item[:price]
end

def checkout(cart,coupons)
  consolidated_cart = consolidate_cart(cart)
  apply_coupons(consolidated_cart,coupons)
  consolidated_cart = apply_clearance(consolidated_cart)
  sum = 0
  i = 0
  while i < consolidated_cart.length
    sum += total_price_by_item(consolidated_cart[i])
    i += 1
  end  
  if sum >= 100
    sum -= sum * 0.1
  end
  return sum 
end