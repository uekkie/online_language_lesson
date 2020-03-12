class Coupon < ActiveHash::Base
  self.data = [
    {id: 1, name: "1回", price: 2000, number: 1},
    {id: 2, name: "5回", price: 8000, number: 5},
    {id: 3, name: "10回", price: 15000, number: 10}
  ]
end
