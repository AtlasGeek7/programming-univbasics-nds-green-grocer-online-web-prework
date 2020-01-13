$idx = -1

def find_item_by_name_in_collection(name, collection)
  i = 0
  while i < collection.length do
    if (collection[i][:item] === name)
      $idx = i
      return collection[i]
    end
    i += 1
  end
  return nil
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  arr = []
  i = 0
  j = 0
  while i < cart.length do
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

def apply_coupons(cart, coupons)
  i = 0
  while i < cart.length do
    j = 0
    while j < coupons.length do
      if cart[i][:item] === coupons[j][:item] && cart[i][:count] >= coupons[j][:num]
        cart << {:item => "#{cart[i][:item]} W/COUPON", :price => coupons[j][:cost] / coupons[j][:num],:clearance => cart[i][:clearance],:count => (cart[i][:count] - (cart[i][:count] % coupons[j][:num]))}
        #if cart[i][:count] % coupons[j][:num] > 0
          cart[i][:count] = cart[i][:count] % coupons[j][:num]
        #else
          #cart.delete_at(i)
        #end
      end
      j += 1
    end
    i += 1  
  end
  return cart
end

def apply_clearance(cart)
  i = 0
  while i < cart.length do
    item = cart[i]
    if item[:clearance]
      discounted_price = ((1 - CLEARANCE_ITEM_DISCOUNT_RATE) * item[:price]).round(2)
        item[:price] = discounted_price
    end
    i += 1
  end

  cart
end

cart = [
      {:item => "AVOCADO", :price => 3.00, :clearance => true},
      {:item => "KALE", :price => 3.00, :clearance => false},
      {:item => "BLACK_BEANS", :price => 2.50, :clearance => false},
      {:item => "ALMONDS", :price => 9.00, :clearance => false},
      {:item => "TEMPEH", :price => 3.00, :clearance => true},
      {:item => "CHEESE", :price => 6.50, :clearance => false},
      {:item => "CHEESE", :price => 6.50, :clearance => false},
      {:item => "KALE", :price => 3.00, :clearance => false},
      {:item => "BEER", :price => 13.00, :clearance => false},
      {:item => "PEANUTBUTTER", :price => 3.00, :clearance => true},
      {:item => "BEETS", :price => 2.50, :clearance => false},
      {:item => "CHEESE", :price => 6.50, :clearance => false},
      {:item => "SOY MILK", :price => 4.50, :clearance => true},
      {:item => "SOY MILK", :price => 4.50, :clearance => true},
      {:item => "CHEESE", :price => 6.50, :clearance => false},
      {:item => "BEER", :price => 13.00, :clearance => false},
      {:item => "CHEESE", :price => 6.50, :clearance => false},
    ]

coupons = [
      {:item => "AVOCADO", :num => 2, :cost => 5.00},
      {:item => "BEER", :num => 2, :cost => 20.00},
      {:item => "CHEESE", :num => 3, :cost => 15.00}
    ]

puts apply_coupons(cart,coupons)
========================================================================================
def find_item_by_name_in_collection(name, collection)
  i = 0
  while i < collection.length do
    if (collection[i][:item] === name)
      return collection[i]
    end
    i += 1
  end
  return nil
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  arr = []
  i = 0
  j = 0
  while i < cart.length do
    if (find_item_by_name_in_collection(cart[i][:item], arr) === nil)
      arr << cart[i]
      arr[j][:count] = 1
      j += 1
    else
      idx = arr.index(cart[i])
      arr[idx][:count] += 1
    end
    i += 1
  end
  return arr
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  arr = []
  i = 0
  while i < cart.length do
    j = 0
    while j < coupons.length do
      if cart[i][:item] === coupons[j][:item] 
        if cart[i][:count] % coupons[j][:num] > 0
          cart[i][:count] = cart[i][:count] % coupons[j][:num]
        else
          cart.delete_at(i)
        end
      #cart << {:item => "#{cart[i][:item]} W/COUPON", :price => coupons[j][:cost] / coupons[j][:num], :clearance => cart[i][:clearance], :count => coupons[j][:num]}  
      #cart << {:item => "#{cart[i][:item]} W/COUPON", :price => coupons[j][:cost] / coupons[j][:num], :clearance => cart[i][:clearance], :count => coupons[j][:num] * (cart[i][:count] / coupons[j][:num])}
          cart.delete_at(i)
      end
      j += 1
    end
    i += 1  
  end
  return cart
end

cart = [
  {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 3},
  {:item => "KALE",    :price => 3.00, :clearance => false, :count => 1}
]

coupons = [{:item => "AVOCADO", :num => 3, :cost => 2.00}]

puts apply_coupons(cart, coupons)
===========================================================
cart = [
  {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 2},
  {:item => "BANANA", :price => 0.5, :clearance => false, :count => 3},
  {:item => "KALE", :price => 3.00, :clearance => false, :count => 1},
  {:item => "MANGO", :price => 2.00, :clearance => true, :count => 3}
]

coupons = [{:item => "MANGO", :num => 2, :cost => 5.00}]

puts apply_coupons(cart, coupons)
================================================================

cart = [
  {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 3},
  {:item => "KALE",    :price => 3.00, :clearance => false, :count => 1}
]

coupons = [{:item => "AVOCADO", :num => 2, :cost => 5.00}]

#==========================================================


def find_item_by_name_in_collection(name, collection)
  i = 0
  while i < collection.length do
    if (collection[i][:item] === name)
      return collection[i]
    end
    i += 1
  end
  return nil
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  arr = []
  i = 0
  j = 0
  while i < cart.length do
    if (find_item_by_name_in_collection(cart[i][:item], arr) == nil)
      arr << cart[i]
      arr[j][:count] = 1
      j += 1
    else
      idx = arr.index(cart[i])
      arr[idx][:count] += 1
    end
    i += 1
  end
  return arr
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end
